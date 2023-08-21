//
//  ProjectUITestCase.swift
//  DemoProjectUITests
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation
import XCTest

class ProjectUITestCase: XCTestCase {
    override func setUp() {
        super.setUp()

        launchApplication()
    }
}

extension XCTestCase {
    func launchApplication() {
        self.continueAfterFailure = false
        XCUIApplication().launch()
    }
}
