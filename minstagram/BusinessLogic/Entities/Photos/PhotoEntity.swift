//
//  PhotoEntity.swift
//  minstagram
//
//  Created by Julien Delferiere on 16/07/2023.
//

import Foundation

struct PhotoEntity: Codable {
    let id: Int
    let width: Int
    let height: Int
    let photographer: String
    let photographerId: Int
    let avgColor: String
    let source: SourceEntity
    let liked: Bool
    let alt: String
    private let stringUrl: String
    private let photographerStringUrl: String
    
    var url: URL? {
        return URL(string: self.stringUrl)
    }
    
    var photographerURL: URL? {
        return URL(string: self.photographerStringUrl)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case photographer
        case photographerId = "photographer_id"
        case avgColor = "avg_color"
        case source = "src"
        case liked
        case alt
        case stringUrl = "url"
        case photographerStringUrl = "photographer_url"
    }
}
