//
//  InvoiceDetailsView.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import SwiftUI

struct InvoiceDetailsView<Model: InvoiceViewModelProtocol>: View, inputCheckable {
    @ObservedObject var invoice: Model

    @Environment(\.presentationMode)
    var presentationMode

    @State private var showAlert = false
    @State private var error: ErrorInfo?

    var body: some View {
        VStack(alignment: .center) {
            Text("Edit Invoice Details")
                .font(.headline)
                .foregroundColor(.blue)
            InvoiceHeaderEditView(invoice: invoice)
            Text("Invoice Items")
                .font(.subheadline)
                .foregroundColor(.blue)
            InvoiceLineListView(invoice: invoice)
            InvoiceLineCreateView<InvoiceLine> { line in
                checkLineInput(line)
            }
            Button {
                if checkNumberInput(invoice.invoiceNumber) {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image(systemName: "delete.left")
            }
            .padding(30)
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(error!.title),
                message: Text(error!.description),
                dismissButton: .default(Text("OK"))
            )
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
