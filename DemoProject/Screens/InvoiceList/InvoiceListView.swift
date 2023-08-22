//
//  InvoiceListView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI

struct InvoiceListView<Model: InvoiceListViewModelProtocol>: View {
    @ObservedObject var viewModel: Model

    @State private var showCreateInvoiceView = false
    @State private var showInvoiceDetailsView = false
    @State private var showAlert = false
    @State private var selectedInvoiceIndex: Int = 0

    var body: some View {
        ZStack {
            invoiceList
            bottomButtonArea
        }
        .sheet(isPresented: $showCreateInvoiceView) {
            CreateInvoiceView<InvoiceViewModel<InvoiceLineViewModel>> {
                invoice in
                if viewModel.validateInvoiceInput(invoice as! Model.InvoiceItem) {
                    viewModel.invoiceList.append(invoice as! Model.InvoiceItem)
                    return true
                } else {
                    showAlert = true
                    return false
                }
            }
        }
        .sheet(isPresented: $showInvoiceDetailsView) {
            InvoiceDetailsView(invoice: viewModel.invoiceList[selectedInvoiceIndex])
        }
        .onAppear {
            viewModel.refreshInvoiceList()
        }
    }

    @ViewBuilder
    private var invoiceList: some View {
        List {
            ForEach(Array(viewModel.invoiceList.enumerated()), id: \.offset) { index, invoice in
                InvoiceCellView(invoice: invoice, delegate: viewModel)
                    .onTapGesture {
                        selectedInvoiceIndex = index
                        showInvoiceDetailsView = true
                    }
                    .modify {
                        if #available(iOS 15.0, *) {
                            $0.listRowSeparator(.hidden)
                        }
                    }
            }
            .onDelete {
                indexSet in
                viewModel.deleteInvoice(by: indexSet)
            }
        }
    }

    @ViewBuilder
    private var bottomButtonArea: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    showCreateInvoiceView = true
                } label: {
                    Image(systemName: "doc.badge.plus")
                }
                .padding(20)
                Button {
                    viewModel.refreshInvoiceList()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .padding(20)
            }
        }
    }
}

struct InvoiceListView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceListView(viewModel: InvoiceListViewModel<InvoiceViewModel<InvoiceLineViewModel>>())
    }
}
