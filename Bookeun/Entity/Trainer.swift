//
//  Trainer.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

struct Trainer {
    let id: String
    let name: String
    let imageURL: URL
    let impactImageURL: URL
}

extension Trainer: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case impactImageURL = "impact_image_url"
    }
}
