//
//  BaseApiService.swift
//  minstagram
//
//  Created by Julien Delferiere on 15/07/2023.
//

import Combine
import Foundation

enum DataState<T: Codable> {
    case loading
    case success(_ data: T)
    case error(_ error: Error?, message: String? = nil)
    case noneState
}

protocol BaseApiServiceProtocol: Actor {
    associatedtype DataType: Codable
    
    var dataState: DataState<DataType> { get set }
    var networkAgent: NetworkAgent { get }
    
    func fetchData(endPoint: EndPointProtocol) async -> DataState<DataType>
}

extension BaseApiServiceProtocol {
    func fetchData(endPoint: EndPointProtocol) async -> DataState<DataType> {
        do {
            let result: Result<DataType, NetworkError> = try await networkAgent.request(for: endPoint)
            switch result {
            case .success(let data):
                return .success(data)
            case .failure(let error):
                switch error {
                case .notFound:
                    return .error(error)
                case .unauthorized:
                    return .error(nil, message: "unauthorized")
                case .badServerResponse:
                    return .error(nil, message: "bad server response")
                case .decodeError(let error):
                    return .error(error, message: "Error when we try to decode data")
                case .encodeError(let error):
                    return .error(error, message: "Error when we try to encode data")
                case .unknowError(let message):
                    return .error(nil, message: message)
                }
            }
        } catch let error {
            return .error(error)
        }
    }
}


