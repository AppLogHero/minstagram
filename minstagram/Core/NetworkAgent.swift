//
//  NetworkAgent.swift
//  minstagram
//
//  Created by Julien Delferiere on 15/07/2023.
//

import Combine
import Foundation

/**
Authorization: NhyXVTu4mf4io6hlDfiuy8E8oKl1egSXfBbgC5vaQ50t8VyNqKn5cXFy

https://api.pexels.com/v1/

https://api.pexels.com/videos/

Search photo:
https://api.pexels.com/v1/search

Curated Photos
https://api.pexels.com/v1/curated

Get a Photo:
https://api.pexels.com/v1/photos/:id
 
Search for Videos
https://api.pexels.com/videos/search
 
Popular videos
https://api.pexels.com/videos/popular
 
Get a video
https://api.pexels.com/videos/videos/:id

429 Too Many Requests
 */
 
final class NetworkAgent: NetworkAgentProtocol {
    
    private var session: URLSession
    
    init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 30
        session = URLSession(configuration: sessionConfiguration)
    }
    
    func request<T: Codable>(for endPoint: EndPointProtocol) async throws -> Result<T, NetworkError> {
        switch getConfiguredRequest(for: endPoint) {
        case .success(let request):
            let (data, response) = try await self.session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("Unknow HTTPURLResponse")
            }
            switch httpResponse.statusCode {
            case 200:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedData)
                } catch let error {
                    return .failure(.decodeError(error))
                }
            case 201...400:
                throw NetworkError.badServerResponse
            case 401:
                throw NetworkError.unauthorized
            case 404:
                throw NetworkError.notFound
            case 500:
                throw NetworkError.badServerResponse
            default:
                throw NetworkError.unknowError("Unknow Error")
            }
        case .failure(let error):
            throw NetworkError.encodeError(error)
        }
    }
    
    private func getConfiguredRequest(for endPoint: EndPointProtocol) -> Result<URLRequest, Error> {
        guard let endPointUrl = URL(string: endPoint.fullPath) else {
            fatalError(
                "Failed to create url from path:"
                + String(describing: endPoint.fullPath)
            )
        }
        var urlComponents = URLComponents(
            url: endPointUrl,
            resolvingAgainstBaseURL: false
        )
        
        urlComponents?.queryItems = endPoint.queryParameters
        
        guard let urlForRequest = urlComponents?.url else {
            fatalError("URL With components is not valid")
        }
        
        var request = URLRequest(url: urlForRequest)
        request.httpMethod = endPoint.httpMethod.rawValue
        
        if let body = endPoint.body {
            do {
                let data = try JSONEncoder().encode(body)
                request.httpBody = data
            } catch let error {
                return .failure(error)
            }
        }
        
        return .success(request)
    }
}
