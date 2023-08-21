//
//  InvoiceHeaderView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI

struct InvoiceHeaderView: View {
    @Binding var invoiceNumber: Int
    @Binding var invoiceDate: Date

    var body: some View {
        HStack {
            Text("Invoice No: \(String(invoiceNumber))")
            Spacer()
            Text("\(formattedDate)")
        }
    }

    private var formattedDate: String {
        DateFormatter.AESTDateFormatter.string(from: invoiceDate)
    }
}
