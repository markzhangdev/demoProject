//
//  InvoiceLineListView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI

struct InvoiceLineListView<Model: InvoiceViewModelProtocol>: View {
    @ObservedObject var invoice: Model
    var maxshownLines = 0

    var body: some View {

        let displayLines = maxshownLines > 0 ? invoice.previewLineItems(maxshownLines) : invoice.lineItems
        ForEach(displayLines) { line in
            HStack {
                InvoiceLineView(invoiceLine: line)
                Button {
                    invoice.removeInvoiceLine(withItem: line)
                } label: {
                    Image(systemName: "minus.circle")
                }
                .frame(height: 16)
                // SwiftUI ForEach issue need this
                .buttonStyle(.borderless)
            }
        }
    }
}
