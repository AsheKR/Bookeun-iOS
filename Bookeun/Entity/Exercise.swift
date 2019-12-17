//
//  Exercise.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

struct Exercise {
    let id: Int
    let name: String
    let englishName: String
    let category: ExerciseCategory
    let exerciseTime: Int?
    let calorie: Int?
    let power: ExercisePower?
    let explainList: [String]
    let imageURLs: [ExerciseImageURL]
}

extension Exercise: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, category, calorie, power
        case englishName = "english_name"
        case explainList = "descriptions"
//        case exerciseTime = "exercise_time"
        case exerciseTime = "time"
        case imageURLs = "images"
    }
}

enum ExercisePower: String, Codable {
    case weak, normal, strong
}
