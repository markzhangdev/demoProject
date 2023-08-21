//
//  InvoiceLineCreateView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI

struct InvoiceLineCreateView<InvoiceLineItem: InvoiceLineProtocol>: View {
    @State var invoiceLineId: String = ""
    @State var description: String = ""
    @State var quantity: String = ""
    @State var cost: String = ""

    @State
    private var showAlert = false

    private var completion: (_ line: InvoiceLineItem) -> Bool

    public init(completion: @escaping (_: InvoiceLineItem) -> Bool) {
        self.completion = completion
    }

    var body: some View {
        HStack {
            TextField("Item ID", text: $invoiceLineId)
                .font(.system(size: 14))
                .numbersOnly($invoiceLineId, includeDecimal: false)
            TextField("Description", text: $description)
                .font(.system(size: 14))
            TextField("Quantity", text: $quantity)
                .font(.system(size: 14))
                .numbersOnly($quantity, includeDecimal: false)
            TextField("Cost", text: $cost)
                .font(.system(size: 14))
                .numbersOnly($cost, includeDecimal: true)
            Button {
                if completion(InvoiceLineItem(invoiceLineId: Int(invoiceLineId) ?? 0, description: description, quantity: Int(quantity) ?? 0, cost: Decimal(string: cost) ?? 0)) {
                    resetInputs()
                }
            } label: {
                Image(systemName: "plus.circle")
            }
        }
    }

    private func resetInputs() {
        invoiceLineId = ""
        description = ""
        quantity = ""
        cost = ""
    }
}
