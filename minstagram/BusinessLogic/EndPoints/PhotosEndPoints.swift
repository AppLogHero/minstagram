//
//  SearchPhotosEndPoint.swift
//  minstagram
//
//  Created by Julien Delferiere on 16/07/2023.
//

import Foundation

enum PhotosEndPoints: EndPointProtocol {
    case search(query: String, perPage: Int)
    case curated(perPage: Int)
    case getPhoto(id: Int)
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .search:
            return "v1/search"
        case .curated:
            return "v1/curated"
        case .getPhoto(let id):
            return "v1/photos/\(id)"
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .search(let query, let perPage):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        case .curated(let perPage):
            return [URLQueryItem(name: "per_page", value: String(perPage))]
        case .getPhoto:
            return nil
        }
    }
    
    var body: Codable? {
        return nil
    }
}
