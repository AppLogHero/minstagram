//
//  SourceEntity.swift
//  minstagram
//
//  Created by Julien Delferiere on 16/07/2023.
//

import Foundation

struct SourceEntity: Codable {
    private let original: String
    private let large2x: String
    private let large: String
    private let medium: String
    private let small: String
    private let portrait: String
    private let landscape: String
    private let tiny: String
    
    var originalPhotoURL: URL? {
        return URL(string: self.original)
    }
    
    var large2xPhotoURL: URL? {
        return URL(string: self.large2x)
    }
    
    var largePhotoURL: URL? {
        return URL(string: self.large)
    }
    
    var mediumPhotoURL: URL? {
        return URL(string: self.medium)
    }
    
    var smallPhotoURL: URL? {
        return URL(string: self.small)
    }
    
    var portraitPhotoURL: URL? {
        return URL(string: self.portrait)
    }
    
    var landscapePhotoURL: URL? {
        return URL(string: self.landscape)
    }
    
    var tinyPhotoURL: URL? {
        return URL(string: self.tiny)
    }
}
