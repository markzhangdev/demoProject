//
//  JSONSerializable.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public protocol JSONSerializable {
    func serializeToJSON() -> Data?
}

public extension JSONSerializable where Self: Encodable {
    func serializeToJSON() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
