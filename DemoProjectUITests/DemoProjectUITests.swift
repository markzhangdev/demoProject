//
//  DemoProjectUITests.swift
//  DemoProjectUITests
//
//  Created by Zhang, Mark on 21/8/2023.
//

import XCTest

class DemoProjectUITests: ProjectUITestCase {
    func testJourneyCreateNewInvoiceSuccess() {
        guard var invoiceListScreen = InvoiceListScreen.waitforInstance() else {
            XCTFail("Fail to load InvoiceListScreen")
            return
        }

        let createInvoiceScreen = invoiceListScreen.clickCreateInvoiceButton()
        XCTAssertTrue(createInvoiceScreen.exists())

        invoiceListScreen = createInvoiceScreen.createNewInvoice()
        XCTAssertTrue(invoiceListScreen.exists())
        XCTAssertTrue(invoiceListScreen.checkNewInvoiceExists())
    }

}
