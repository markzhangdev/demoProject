//
//  HTTPURLResponse+Status.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public extension HTTPURLResponse {
    var wasSuccessful: Bool {
        let successRange = 200 ..< 300
        return successRange.contains(statusCode)
    }
}
