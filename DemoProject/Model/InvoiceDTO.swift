//
//  InvoiceDTO.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public struct InvoiceDTO {
    public var invoiceNumber: Int?
    public var invoiceDate: Date?
    public var lineItems: [InvoiceLineDTO]?
}

extension InvoiceDTO: Codable, JSONSerializable {}
