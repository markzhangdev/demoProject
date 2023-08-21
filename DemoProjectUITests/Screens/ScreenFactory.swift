//
//  ScreenFactory.swift
//  DemoProjectUITests
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation
import XCTest

protocol UITestScreen {
    associatedtype ScreenType

    static func waitforInstance() -> ScreenType?
    func exists() -> Bool
}

enum ScreenFactory {
    static func screen<T: UITestScreen>(ofType type: T.Type) -> T {
        guard let expectedScreen = T.waitforInstance() as? T else {
            XCTFail("Unable to get \(type)")
            return InvoiceListScreen() as! T // will never get called
        }
        return expectedScreen
    }

    static var invoiceListScreen: InvoiceListScreen {
        return screen(ofType: InvoiceListScreen.self)
    }

    static var createInvoiceScreen: CreateInvoiceScreen {
        return screen(ofType: CreateInvoiceScreen.self)
    }
}
