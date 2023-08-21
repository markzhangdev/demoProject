//
//
//  InvoiceAPIService.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

final class InvoiceAPIService {
    static func getInvoiceList(path: String,
                               method: HTTPMethod,
                               query: [String: String]? = nil,
                               body: JSONSerializable? = nil,
                               with requestBuilder: NetworkAPIRequestBuilderProtocol = NetworkAPIRequestBuilder(),
                               and apiClient: NetworkAPIClientProtocol = NetworkAPIClient()) async throws -> [InvoiceDTO]
    {
        let invoiceListRequest = InvoiceAPIRequest(path: path, method: method, query: query, body: body)
        let urlRequest = try await requestBuilder.build(with: invoiceListRequest)
        return try await apiClient.fetchData(with: urlRequest)
    }
}
