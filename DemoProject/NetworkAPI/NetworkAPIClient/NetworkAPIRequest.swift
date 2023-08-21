//
//  NetworkAPIRequest.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

protocol RestRequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var url: URL? { get }
    var query: [String: String]? { get set }
    var body: JSONSerializable? { get set }
}
