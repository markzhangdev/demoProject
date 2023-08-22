//
//  CreateInvoiceView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI

struct CreateInvoiceView<Model: InvoiceViewModelProtocol>: View, inputCheckable {
    @Environment(\.presentationMode)
    var presentationMode

    private var completion: (_ invoice: Model) -> Bool

    @State var invoice: Model = .init(invoiceNumber: 0, invoiceDate: Date(), lineItems: [])!
    @State private var showAlert = false
    @State private var error: ErrorInfo?

    public init(completion: @escaping (_ invoice: Model) -> Bool) {
        self.completion = completion
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Create New Invoice")
                .font(.headline)
                .foregroundColor(.blue)
            InvoiceHeaderEditView(invoice: invoice)
            Text("Invoice Items")
                .font(.subheadline)
                .foregroundColor(.blue)
            InvoiceLineListView(invoice: invoice)
            InvoiceLineCreateView<InvoiceLineViewModel> { line in
                checkLineInput(line)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(error!.title),
                message: Text(error!.description),
                dismissButton: .default(Text("OK"))
            )
        }
        buttonsArea
    }

    @ViewBuilder
    private var buttonsArea: some View {
        HStack {
            Button {
                if !checkNumberInput(invoice.invoiceNumber) {
                    return
                }
                if completion(invoice) {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image(systemName: "plus.app")
            }
            .padding(30)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "delete.left")
            }
            .padding(30)
        }
    }

    private func checkLineInput(_ line: any InvoiceLineProtocol) -> Bool {
        if let errorInfo = checkLineInput(line: line) {
            error = errorInfo
            showAlert = true
            return false
        }

        invoice.addInvoiceLine(line as! Model.InvoiceLineItem)
        return true
    }

    @discardableResult
    private func checkNumberInput(_ number: Int) -> Bool {
        if let errorInfo = checkInvoiceNumberInput(number) {
            error = errorInfo
            showAlert = true
            return false
        }
        return true
    }
}
