//
//  InvoiceLineDTO.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public struct InvoiceLineDTO {
    public var invoiceLineId: String?
    public var description: String?
    public var quantity: String?
    public var cost: String?
}

extension InvoiceLineDTO: Codable, JSONSerializable {}
