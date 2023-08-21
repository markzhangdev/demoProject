//
//  InputChecker.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

protocol inputCheckable {}

extension inputCheckable {
    func checkLineInput(line: any InvoiceLineProtocol) -> ErrorInfo? {
        guard line.invoiceLineId > 0 else {
            return ErrorInfo(id: 1, title: "Wrong item ID", description: "Please input correct item ID")
        }

        guard line.quantity >= 1 else {
            return ErrorInfo(id: 2, title: "Wrong quantity", description: "Please input correct quantity number")
        }

        guard line.cost != 0 else {
            return ErrorInfo(id: 3, title: "Wrong cost", description: "Please input correct cost")
        }

        return nil
    }

    func checkInvoiceNumberInput(_ number: Int) -> ErrorInfo? {
        guard number > 0 else {
            return ErrorInfo(id: 4, title: "Wrong invoice number", description: "Please input correct invoice number")
        }
        return nil
    }
}
