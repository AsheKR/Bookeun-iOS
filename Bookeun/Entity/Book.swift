//
//  Book.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

struct Book {
    let id: Int
    let isbn: String
    let name: String
    let coverImageURL: URL
    let author: Author
    let weight: Double
    let page: Int
    let salePrice: Int
}

extension Book: Codable {
    enum CodingKeys: String, CodingKey {
        case id, isbn, name, author, weight, page
        case coverImageURL = "cover_image_url"
        case salePrice = "sale_price"
    }
}

struct Author: Codable {
    let id: Int
    let name: String
}
