//
//  InvoiceLine.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//
import Foundation

public protocol InvoiceLineProtocol: ObservableObject, Identifiable, Equatable {
    var id: UUID { get }
    var invoiceLineId: Int { get set }
    var description: String { get set }
    var quantity: Int { get set }
    var cost: Decimal { get set }
    init(invoiceLineId: Int, description: String, quantity: Int, cost: Decimal)
    init? (_ lineDTO: InvoiceLineDTO)
}

public class InvoiceLine: InvoiceLineProtocol {
    public let id = UUID()
    @Published
    public var invoiceLineId: Int
    @Published
    public var description: String
    @Published
    public var quantity: Int
    @Published
    public var cost: Decimal

    public required init(invoiceLineId: Int, description: String, quantity: Int, cost: Decimal) {
        self.invoiceLineId = invoiceLineId
        self.description = description
        self.quantity = quantity
        self.cost = cost.rounded(2, .bankers)
    }

    public required init? (_ lineDTO: InvoiceLineDTO) {
        guard let invoiceLineId = Int(lineDTO.invoiceLineId ?? ""),
              let description = lineDTO.description,
              let quantity = lineDTO.quantity,
              let cost = Decimal(string: lineDTO.cost ?? "") else { return nil }
        self.invoiceLineId = invoiceLineId
        self.description = description
        self.quantity = Int(quantity) ?? 0
        self.cost = cost.rounded(2, .bankers)
    }

    public static func == (lhs: InvoiceLine, rhs: InvoiceLine) -> Bool {
        // MARK: Not sure about the real business requirement of how to define

        /// two lines are equal (same), just compare ID and quantity for now
        (lhs.invoiceLineId == rhs.invoiceLineId) && (lhs.quantity == rhs.quantity)
    }
}
