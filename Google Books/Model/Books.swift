//
//  Books.swift
//  Google Books
//
//  Created by Lo Howard on 9/13/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import Foundation

struct Books: Codable {
    let items: [Item]
}

struct Item: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let volumeInfoDescription: String?
    let averageRating: Double?
    let imageLinks: ImageLinks
    
    enum CodingKeys: String, CodingKey {
        case title, subtitle, authors, imageLinks, averageRating
        case volumeInfoDescription = "description"
    }
}

struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}
