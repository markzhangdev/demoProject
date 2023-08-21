//
//  XCTestUtil.swift
//  DemoProjectUITests
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation
import XCTest

let WAIT_TIMEOUT: TimeInterval = 5

@discardableResult
func waitforElement(element: XCUIElement) -> Bool {
    return waitforElement(element: element, timeout: WAIT_TIMEOUT)
}

func waitforElement(element: XCUIElement, timeout: TimeInterval) -> Bool {
    return element.waitForExistence(timeout: timeout)
}

func clickOnElement(_ message: String, _ element: XCUIElement) {
    if waitforElement(element: element) {
        XCTAssertTrue(element.isHittable, "NOT hittable \(message)")
        element.tap()
    } else {
        XCTFail(message)
    }
}
