//
//  Exercise.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

struct Exercise {
    let id: String
    let name: String
    let category: ExerciseCategory
    let exerciseTime: Int
    let calorie: Int
    let power: ExercisePower
    let explainList: [String]
    let imageURLs: [URL]
}

extension Exercise: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, category, calorie, power
        case explainList = "descriptions"
        case exerciseTime = "exercise_time"
        case imageURLs = "image_urls"
    }
}

enum ExercisePower: String, Codable {
    case weak, normal, strong
}
