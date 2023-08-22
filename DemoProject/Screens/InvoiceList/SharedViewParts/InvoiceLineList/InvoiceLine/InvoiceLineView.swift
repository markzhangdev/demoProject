//
//  InvoiceLineView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//
import SwiftUI

struct InvoiceLineView<Model: InvoiceLineProtocol>: View {
    @ObservedObject var invoiceLine: Model
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(String(invoiceLine.invoiceLineId))
                    .font(.system(size: 14))
                    .frame(width: geometry.size.width * 0.15)

                Text(invoiceLine.description)
                    .font(.system(size: 14))
                    .frame(width: geometry.size.width * 0.25)

                Text("X\(String(invoiceLine.quantity))")
                    .font(.system(size: 14))
                    .frame(width: geometry.size.width * 0.15)
                    .keyboardType(.numberPad)

                Text(NumberFormatter.currencyFormatterAUD().string(from: NSDecimalNumber(decimal: invoiceLine.cost)) ?? "")
                    .font(.system(size: 14))
                    .frame(width: geometry.size.width * 0.25)
            }
        }
        .frame(height: 16)
    }
}

struct InvoiceLineView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceLineView(invoiceLine: InvoiceLineViewModel(invoiceLineId: 1, description: "first line", quantity: 2, cost: 2.22))
    }
}
