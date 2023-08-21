//
//  NetworkAPIClient.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation
import SwiftUI

enum NetworkAPIClientError: Error {
    case invalidURL
    case invalidJSON
    case invalidResponse
    case emptyResponse
}

protocol NetworkAPIClientProtocol {
    func fetchData<T: Decodable>(with request: URLRequest) async throws -> T
}

public actor NetworkAPIClient: NetworkAPIClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(session: URLSession = URLSession.shared,
                decoder: JSONDecoder = JSONDecoder())
    {
        self.session = session
        self.decoder = decoder
    }

    @discardableResult
    func fetchData<T: Decodable>(with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        if let response = response as? HTTPURLResponse {
            if response.wasSuccessful == false {
                throw NetworkAPIClientError.invalidResponse
            }
        }

        let result = try await Task.detached { [decoder] in
            try decoder.decode(T.self, from: data)
        }.value

        return result
    }
}
