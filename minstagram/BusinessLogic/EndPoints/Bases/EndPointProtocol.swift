//
//  EndPointProtocol.swift
//  minstagram
//
//  Created by Julien Delferiere on 15/07/2023.
//

import Foundation

protocol EndPointProtocol {
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var baseURL: String { get }
    var fullPath: String { get }
    var headers: [String: String] { get }
    var queryParameters: [URLQueryItem]? { get }
    var body: Codable? { get }
}

extension EndPointProtocol {
    var baseURL: String {
        return "https://api.pexels.com/"
    }
    
    var fullPath: String {
        return baseURL + path
    }
    
    var headers: [String : String] {
        return ["Autorization": "NhyXVTu4mf4io6hlDfiuy8E8oKl1egSXfBbgC5vaQ50t8VyNqKn5cXFy"]
    }
}


