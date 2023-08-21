//
//  InvoiceAPIRequest.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

struct InvoiceAPIRequest: RestRequestProtocol {
    private static let baseURL = "https://api.github.com"

    let path: String

    var method: HTTPMethod

    var query: [String: String]?

    var body: JSONSerializable?

    init(path: String,
         method: HTTPMethod = .get,
         query: [String: String]? = nil,
         body: JSONSerializable? = nil)
    {
        self.path = path
        self.method = method
        self.query = query
        self.body = body
    }
}

extension InvoiceAPIRequest {
    var url: URL? {
        guard let url = URL(string: InvoiceAPIRequest.baseURL) else { return nil }
        guard let pathURL = URL(string: path, relativeTo: url) else { return nil }
        return pathURL
    }
}
