//
//  InvoiceListViewModelTest.swift
//  DemoProjectTests
//
//  Created by Zhang, Mark on 21/8/2023.
//

import XCTest
@testable import DemoProject

final class InvoiceListViewModelTest: ProjectTestCase {
    var viewModel: InvoiceListViewModel<InvoiceViewModel<InvoiceLineViewModel>>?
    var invoice: InvoiceViewModel<InvoiceLineViewModel> {
        viewModel!.invoiceList[0]
    }

    override func setUp() {
        super.setUp()
        viewModel = InvoiceListViewModel<InvoiceViewModel<InvoiceLineViewModel>>()
        viewModel!.invoiceList = []
        viewModel!.createInvoice(invoiceDate: Date(timeIntervalSince1970: 0))
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testCreateInvoiceWithOneItem() {
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                           description: "Pizza",
                                           quantity: 1,
                                           cost: 9.99))
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                           description: "Pizza",
                                           quantity: 1,
                                           cost: 9.99))

        viewModel?.updateInvoiceList(with: [invoice])
        XCTAssertEqual(viewModel?.invoiceList.count, 1)
    }

    func testCreateInvoiceWithMultipleItemsAndQuantities() {
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                           description: "Banana",
                                           quantity: 4,
                                           cost: Decimal(10.21)))

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                           description: "Orange",
                                           quantity: 1,
                                           cost: Decimal(5.21)))

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 3,
                                           description: "Pizza",
                                           quantity: 5,
                                           cost: 5.21))

        XCTAssertTrue(invoice.lineItems[0].cost.isEqual(to: Decimal(string: "10.21")!))
        XCTAssertTrue(invoice.lineItems[1].cost.isEqual(to: Decimal(string: "5.21")!))
        XCTAssertTrue(invoice.lineItems[2].cost.isEqual(to: Decimal(string: "5.21")!))
        XCTAssertTrue(invoice.getTotal().isEqual(to: Decimal(string: "72.10")!))
    }

    func testRemoveItem() {
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                           description: "Orange",
                                           quantity: 1,
                                           cost: 5.22))

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                           description: "Banana",
                                           quantity: 4,
                                           cost: 10.33))

        invoice.removeInvoiceLine(withLineId: 1)
        XCTAssertTrue(invoice.getTotal().isEqual(to: Decimal(string: "41.32")!))
    }

    func testMergeInvoices() {
        let invoice1 = invoice
        viewModel!.createInvoice()
        var invoice2 = viewModel!.invoiceList[1]

        invoice1.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                            description: "Banana",
                                            quantity: 4,
                                            cost: 10.33))

        invoice2.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                            description: "Orange",
                                            quantity: 1,
                                            cost: 5.22))

        invoice2.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 3,
                                            description: "Blueberries",
                                            quantity: 3,
                                            cost: 6.27))

        invoice1.mergeInvoices(with: &invoice2)
        XCTAssertTrue(invoice.getTotal().isEqual(to: Decimal(string: "65.35")!))
    }

    @MainActor
    func testCloneInvoice() {
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                           description: "Apple",
                                           quantity: 1,
                                           cost: 6.99)
        )

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                           description: "Blueberries",
                                           quantity: 3,
                                           cost: 6.27))

        let expectation = XCTestExpectation(description: "Async task finished")

        Task {
            guard let clone: InvoiceViewModel<InvoiceLineViewModel> = try? await invoice.clone() else {
                XCTFail("Clone Invoice Failed")
                return
            }
            XCTAssertTrue(clone.getTotal().isEqual(to: Decimal(string: "25.8")!))
            XCTAssertEqual(invoice.toString(), "Invoice Number: 1, InvoiceDate: 01/01/1970, LineItemCount: 2")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func testInvoiceToString() {
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                           description: "Apple",
                                           quantity: 1,
                                           cost: 6.99))

        XCTAssertEqual(invoice.toString(), "Invoice Number: 1, InvoiceDate: 01/01/1970, LineItemCount: 1")
    }

    func testOrderLineItems() {
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 3,
                                           description: "Banana",
                                           quantity: 4,
                                           cost: 10.21))

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                           description: "Orange",
                                           quantity: 1,
                                           cost: 5.21))

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                           description: "Pizza",
                                           quantity: 5,
                                           cost: 5.21))

        invoice.oderLineItems()
        XCTAssertEqual(invoice.toString(), "Invoice Number: 1, InvoiceDate: 01/01/1970, LineItemCount: 3")
        XCTAssertEqual(invoice.lineItems[0].invoiceLineId, 1)
        XCTAssertEqual(invoice.lineItems[1].invoiceLineId, 2)
        XCTAssertEqual(invoice.lineItems[2].invoiceLineId, 3)
    }

    func testPreviewLineItems() {
        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                           description: "Banana",
                                           quantity: 4,
                                           cost: 10.21))

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                           description: "Orange",
                                           quantity: 1,
                                           cost: 5.21))

        invoice.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 3,
                                           description: "Pizza",
                                           quantity: 5,
                                           cost: 5.21))

        var items = invoice.previewLineItems(1)
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items[0].invoiceLineId, 1)

        items = invoice.previewLineItems(5)
        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items[2].invoiceLineId, 3)

        items = invoice.previewLineItems(3)
        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items[0].invoiceLineId, 1)
    }

    func testRemoveExtraItems() {
        let invoice1 = invoice
        viewModel!.createInvoice()
        let invoice2 = viewModel!.invoiceList[1]

        invoice1.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                            description: "Banana",
                                            quantity: 4,
                                            cost: 10.33))

        invoice1.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 3,
                                            description: "Blueberries",
                                            quantity: 3,
                                            cost: 6.27))

        invoice2.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                            description: "Orange",
                                            quantity: 1,
                                            cost: 5.22))

        invoice2.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 3,
                                            description: "Blueberries",
                                            quantity: 3,
                                            cost: 6.27))

        invoice2.removeItems(from: invoice1)
        XCTAssertEqual(invoice2.lineItems.count, 1)
        XCTAssertEqual(invoice2.lineItems[0].invoiceLineId, 2)
        XCTAssertTrue(invoice2.getTotal().isEqual(to: Decimal(string: "5.22")!))
    }

    func testGetInvoices() {
        let invoice1 = invoice
        viewModel!.createInvoice()
        let invoice2 = viewModel!.invoiceList[1]
        viewModel!.createInvoice()
        let invoice3 = viewModel!.invoiceList[2]

        invoice1.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                            description: "Banana",
                                            quantity: 4,
                                            cost: 10.33))

        invoice2.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                            description: "Orange",
                                            quantity: 1,
                                            cost: 5.22))

        invoice2.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 2,
                                            description: "Blueberries",
                                            quantity: 3,
                                            cost: 6.27))

        invoice3.addInvoiceLine(InvoiceLineViewModel(invoiceLineId: 1,
                                            description: "Pizza",
                                            quantity: 1,
                                            cost: 9.99))

        guard let fetchedInvoices = viewModel?.getInvoices() else {
            XCTFail("Failed to get invoices")
            return
        }
        XCTAssertEqual(fetchedInvoices.count, 3)
        XCTAssertEqual(fetchedInvoices[0].lineItems[0].description, "Banana")
        XCTAssertEqual(fetchedInvoices[1].lineItems[0].description, "Orange")
        XCTAssertEqual(fetchedInvoices[1].lineItems[1].description, "Blueberries")
        XCTAssertEqual(fetchedInvoices[2].lineItems[0].description, "Pizza")
    }
}

