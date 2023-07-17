//
//  NetworkAgentProtocol.swift
//  minstagram
//
//  Created by Julien Delferiere on 15/07/2023.
//

import Foundation

enum NetworkError: Error {
    case notFound
    case unauthorized
    case badServerResponse
    case decodeError(_ error: Error)
    case encodeError(_ error: Error)
    case unknowError(_ message: String)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol NetworkAgentProtocol {
    func request<T: Codable>(for endPoint: EndPointProtocol) async throws -> Result<T, NetworkError>
}
