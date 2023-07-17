//
//  VideosEndPoints.swift
//  minstagram
//
//  Created by Julien Delferiere on 16/07/2023.
//

import Foundation

enum VideoEndPoints: EndPointProtocol {
    case search(query: String, perPage: Int)
    case popular(perPage: Int)
    case getVideo(id: Int)
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .search:
            return "videos/search"
        case .popular:
            return "videos/popular"
        case .getVideo(let id):
            return "videos/videos/\(id)"
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .search(let query, let perPage):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        case .popular(let perPage):
            return [URLQueryItem(name: "per_page", value: String(perPage))]
        case .getVideo:
            return nil
        }
    }
    
    var body: Codable? {
        return nil
    }
}
