//
//  InvoiceListScreen.swift
//  DemoProjectUITests
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation
import XCTest

class InvoiceListScreen: UITestScreen {
    typealias ScreenType = InvoiceListScreen
    let app = XCUIApplication()

    static func waitforInstance() -> InvoiceListScreen? {
        let header = XCUIApplication().staticTexts["Invoice List"]
        if waitforElement(element: header) {
            return InvoiceListScreen()
        }
        return nil
    }

    func exists() -> Bool {
        let header = app.staticTexts["Invoice List"]
        return header.exists
    }

    func clickCreateInvoiceButton() -> CreateInvoiceScreen {
        let createInvoiceButton = app.buttons["doc.badge.plus"]
        clickOnElement("unable to click create invoice button in InvoiceListScreen", createInvoiceButton)
        return ScreenFactory.createInvoiceScreen
    }

    func checkNewInvoiceExists() -> Bool {
        return app.staticTexts["Best item"].exists
    }
}
