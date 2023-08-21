//
//  CreateInvoiceScreen.swift
//  DemoProjectUITests
//
//  Created by Zhang, Mark on 21/8/2023.
//
import Foundation
import XCTest

class CreateInvoiceScreen: UITestScreen {
    typealias ScreenType = CreateInvoiceScreen
    let app = XCUIApplication()

    static func waitforInstance() -> CreateInvoiceScreen? {
        let header = XCUIApplication().staticTexts["Create New Invoice"]
        if waitforElement(element: header) {
            return CreateInvoiceScreen()
        }
        return nil
    }

    func exists() -> Bool {
        let header = app.staticTexts["Create New Invoice"]
        return header.exists
    }

    func createNewInvoice() -> InvoiceListScreen {
        enterInvoiceNumber(invoiceNumber: "123")
        enterItemID(itemID: "33")
        enterDescription(description: "Best item")
        enterQuantity(quantity: "3")
        enterCost(cost: "2.12")
        clickAddLineButton()
        clickCreateInvoiceButton()
        return ScreenFactory.invoiceListScreen
    }

    func enterInvoiceNumber(invoiceNumber: String) {
        let invoiceNumberField = app.textFields["Invoice Number"]
        invoiceNumberField.tap()
        invoiceNumberField.typeText(invoiceNumber)
    }

    func enterItemID(itemID: String) {
        let itemIDField = app.textFields["Item ID"]
        itemIDField.tap()
        itemIDField.typeText(itemID)
    }

    func enterDescription(description: String) {
        let descriptionField = app.textFields["Description"]
        descriptionField.tap()
        descriptionField.typeText(description)
    }

    func enterQuantity(quantity: String) {
        let quantityField = app.textFields["Quantity"]
        quantityField.tap()
        quantityField.typeText(quantity)
    }

    func enterCost(cost: String) {
        let costField = app.textFields["Cost"]
        costField.tap()
        costField.typeText(cost)
    }

    func clickAddLineButton() {
        let addLineButton = app.buttons["Add"]
        clickOnElement("unable to click add line button in CreateInvoiceScreen", addLineButton)
    }

    func clickCreateInvoiceButton() {
        let createInvoiceButton = app.buttons["Add To Home Screen"]
        clickOnElement("unable to click add line button in CreateInvoiceScreen", createInvoiceButton)
    }
}
