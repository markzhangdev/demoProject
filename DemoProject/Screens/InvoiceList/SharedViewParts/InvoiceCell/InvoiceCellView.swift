//
//  InvoiceCellView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI

protocol InvoiceCellViewDelegate {
    func cloneInvoice(from invoice: some InvoiceViewModelProtocol)
}

struct InvoiceCellView<Model: InvoiceViewModelProtocol>: View {
    @ObservedObject var invoice: Model
    var delegate: InvoiceCellViewDelegate?
    let maxshownLines = 1
    var moreToShow: Bool {
        invoice.lineItems.count > maxshownLines
    }

    private var formattedDate: String {
        DateFormatter.AESTDateFormatter.string(from: invoice.invoiceDate)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                InvoiceHeaderView(invoiceNumber: $invoice.invoiceNumber, invoiceDate: $invoice.invoiceDate)
                InvoiceLineListView(invoice: invoice, maxshownLines: maxshownLines)
                Text(moreToShow ? "..." : "")
            }
            .padding()
            .frame(height: 100)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            Button {
                delegate?.cloneInvoice(from: invoice)
            } label: {
                Image(systemName: "doc.on.doc")
            }
            // SwiftUI ForEach issue need this
            .buttonStyle(.borderless)
        }

    }
}

struct InvoiceCellView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceCellView(invoice: InvoiceViewModel(invoiceNumber: 1, invoiceDate: Date(), lineItems: [InvoiceLineViewModel(invoiceLineId: 1, description: "first line", quantity: 2, cost: 2.22),
                                                                                            InvoiceLineViewModel(invoiceLineId: 2, description: "first line", quantity: 2, cost: 2.22)])!)
    }
}
