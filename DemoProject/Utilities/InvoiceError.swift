//
//  InvoiceError.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

enum InvoiceError: Error {
    case dataError
}

struct ErrorInfo: Identifiable {
    var id: Int
    let title: String
    let description: String
}
