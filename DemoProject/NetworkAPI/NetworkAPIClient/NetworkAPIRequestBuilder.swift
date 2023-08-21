//
//  NetworkAPIRequestBuilder.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

protocol NetworkAPIRequestBuilderProtocol {
    func build(with request: RestRequestProtocol) async throws -> URLRequest
}

struct NetworkAPIRequestBuilder: NetworkAPIRequestBuilderProtocol {
    typealias URLRequestDecorator = (URLRequest, RestRequestProtocol) -> URLRequest

    func build(with request: RestRequestProtocol) async throws -> URLRequest {
        guard let url = request.url else {
            throw NetworkAPIClientError.invalidURL
        }
        let urlRequest = URLRequest(url: url)

        let operations = buildDecoratorArray()

        let result = operations.reduce(urlRequest) { result, operation in
            operation(result, request)
        }

        return result
    }

    private func configContentTypeHeader(for urlRequest: URLRequest, with request: RestRequestProtocol) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }

    private func configRequestMethod(for urlRequest: URLRequest, with request: RestRequestProtocol) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }

    private func configQueryParameters(for urlRequest: URLRequest, with request: RestRequestProtocol) -> URLRequest {
        guard let queryParms = request.query else { return urlRequest }
        var urlRequest = urlRequest
        guard let url = urlRequest.url else { fatalError("url is missing in request") }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = queryParms.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        urlComponents?.queryItems = queryItems
        urlRequest.url = urlComponents?.url
        return urlRequest
    }

    private func configJSONBodyParameters(for urlRequest: URLRequest, with request: RestRequestProtocol) -> URLRequest {
        guard let body = request.body else { return urlRequest }
        var urlRequest = urlRequest
        urlRequest.httpBody = body.serializeToJSON()
        return urlRequest
    }

    @URLRequestDecoratorBuilder
    private func buildDecoratorArray() -> [URLRequestDecorator] {
        configContentTypeHeader
        configRequestMethod
        configQueryParameters
        configJSONBodyParameters
    }

    @resultBuilder
    enum URLRequestDecoratorBuilder {
        static func buildBlock(_ components: URLRequestDecorator...) -> [URLRequestDecorator] {
            var result: [URLRequestDecorator] = []
            for component in components {
                result.append(component)
            }
            return result
        }
    }
}
