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
    let name: String
    let coverImageURL: URL
    let author: String
    let publisher: String
    let weight: Double
    let page: Int
    let grade: Int
    let reviews: [String]
    let salePrice: Double
    let usedPrice: Double
}

extension Book: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, author, publisher, weight, page, grade, reviews
        case coverImageURL = "cover_image_url"
        case salePrice = "sale_price"
        case usedPrice = "used_price"
    }
}
