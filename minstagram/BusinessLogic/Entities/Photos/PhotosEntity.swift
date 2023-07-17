//
//  PhotosEntity.swift
//  minstagram
//
//  Created by Julien Delferiere on 16/07/2023.
//

import Foundation

struct PhotosEntity: Codable {
    let totalResults: Int?
    let page: Int
    let perPage: Int
    let photos: [PhotosEntity]
    let nextPageStringUrl: String
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case perPage = "per_page"
        case photos
        case nextPageStringUrl = "next_page"
    }
}
