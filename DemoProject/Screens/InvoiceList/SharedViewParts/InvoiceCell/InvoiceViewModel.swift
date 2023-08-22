//
//  InvoiceViewModel.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public protocol InvoiceViewModelProtocol: ObservableObject, Identifiable {
    associatedtype InvoiceLineItem: InvoiceLineProtocol

    var id: UUID { get }
    var invoiceNumber: Int { get set }
    var invoiceDate: Date { get set }
    var lineItems: [InvoiceLineItem] { get set }

    init? (invoiceNumber: Int, invoiceDate: Date, lineItems: [InvoiceLineItem])

    init? (_ invoiceDTO: InvoiceDTO)

    func removeInvoiceLine(withItem line: InvoiceLineItem)
    func addInvoiceLine(_ line: InvoiceLineItem)
    func previewLineItems(_ max: Int) -> [InvoiceLineItem]
    func clone<T: InvoiceViewModelProtocol>() async throws -> T
}

///
///
/// Warning: This part is over engineered for a simple app.
/// Only trying to demonstrate my ablility to work with protocol oriented programming complex app
///
///

public final class InvoiceViewModel<InvoiceLineItem: InvoiceLineProtocol>: InvoiceViewModelProtocol {
    public let id = UUID()
    @Published
    public var invoiceNumber: Int
    @Published
    public var invoiceDate: Date
    @Published
    public var lineItems: [InvoiceLineItem]

    var totalCost: Decimal {
        lineItems.reduce(Decimal()) { result, item in
            result + item.cost * Decimal(item.quantity)
        }
    }

    public required init? (invoiceNumber: Int, invoiceDate: Date, lineItems: [InvoiceLineItem]) {
        self.invoiceNumber = invoiceNumber
        self.invoiceDate = invoiceDate
        self.lineItems = lineItems
    }

    public required init? (_ invoiceDTO: InvoiceDTO) {
        guard let invoiceNumber = invoiceDTO.invoiceNumber,
              let invoiceDate = invoiceDTO.invoiceDate else { return nil }
        let lineItems = invoiceDTO.lineItems?.compactMap(InvoiceLineItem.init)
        self.invoiceNumber = invoiceNumber
        self.invoiceDate = invoiceDate
        self.lineItems = lineItems ?? []
    }

    public func addInvoiceLine(_ line: InvoiceLineItem) {
        lineItems.append(line)
    }

    // MARK: Not sure if need to delete multiple invoiceLine if there is multiple invoiceLines with same invoiceLineId

    func removeInvoiceLine(withLineId invoiceLineId: Int) {
        guard let index = lineItems.firstIndex(where: { $0.invoiceLineId == invoiceLineId }) else { return }
        removeInvoiceLine(byIndex: index)
    }

    func removeInvoiceLine(byIndex index: Int) {
        lineItems.remove(at: index)
    }

    public func removeInvoiceLine(withItem line: InvoiceLineItem) {
        guard let index = lineItems.firstIndex(of: line) else { return }
        removeInvoiceLine(byIndex: index)
    }

    /// GetTotal should return the sum of (Cost * Quantity) for each line item
    func getTotal() -> Decimal {
        totalCost
    }

    /// MergeInvoices appends the items from the sourceInvoice to the current invoice

    // MARK: use inout here is a bit risky. Better let the caller function of the mergeInvoices

    ///     to hanle the after merge action of the sourceInvoice
    func mergeInvoices(with sourceInvoice: inout InvoiceViewModel) {
        for item in sourceInvoice.lineItems {
            if !lineItems.contains(item) {
                lineItems.append(item)
                sourceInvoice.removeInvoiceLine(withItem: item)
            }
        }
    }

    /// Creates a deep clone of the current invoice (all fields and properties)
    public func clone<T: InvoiceViewModelProtocol>() async throws -> T {
        let newLineItems = lineItems.map {
            InvoiceLineItem(invoiceLineId: $0.invoiceLineId, description: $0.description, quantity: $0.quantity, cost: $0.cost)
        }
        guard let clone = InvoiceViewModel(invoiceNumber: invoiceNumber, invoiceDate: invoiceDate, lineItems: newLineItems) else {
            throw InvoiceError.dataError
        }
        return clone as! T
    }

    /// order the lineItems by Id
    func oderLineItems() {
        /// sort with ascending invoiceLineId
        lineItems.sort(by: { $0.invoiceLineId < $1.invoiceLineId })
    }

    /// returns the number of the line items specified in the variable `max`
    public func previewLineItems(_ max: Int) -> [InvoiceLineItem] {
        Array(lineItems.prefix(max))
    }

    /// remove the line items in the current invoice that are also in the sourceInvoice
    func removeItems(from sourceInvoice: InvoiceViewModel) {
        for item in sourceInvoice.lineItems {
            if lineItems.contains(item) {
                removeInvoiceLine(withItem: item)
            }
        }
    }

    /// Outputs string containing the following (replace [] with actual values):
    /// Invoice Number: [InvoiceNumber], InvoiceDate: [DD/MM/YYYY], LineItemCount: [Number of items in LineItems]
    func toString() -> String {
        let dateString = DateFormatter.AESTDateFormatter.string(from: invoiceDate)
        return "Invoice Number: \(invoiceNumber), InvoiceDate: \(dateString), LineItemCount: \(lineItems.count)"
    }
}
