//
//  InvoiceHeaderEditView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Combine
import SwiftUI

struct InvoiceHeaderEditView<Model: InvoiceViewModelProtocol>: View {
    @ObservedObject var invoice: Model

    public init(invoice: Model) {
        self.invoice = invoice
    }

    var body: some View {
        HStack {
            Text("Invoice No:")
            TextField("Invoice Number", value: $invoice.invoiceNumber, formatter: NumberFormatter.plainNumberFormatter())
                .padding()
                .keyboardType(.numberPad)
            DatePicker("", selection: $invoice.invoiceDate, displayedComponents: .date)
                .padding()
        }
    }
}
