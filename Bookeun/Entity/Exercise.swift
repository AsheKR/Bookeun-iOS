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
    let exerciseTime: Date
    let calorie: Int
    let power: ExercisePower
    let description: String
    let imageURLs: [URL]
}

extension Exercise: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, category, calorie, power, description
        case exerciseTime = "exercise_time_ms"
        case imageURLs = "image_urls"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try value.decode(String.self, forKey: .id)
        self.name = try value.decode(String.self, forKey: .name)
        self.category = try value.decode(ExerciseCategory.self, forKey: .category)
        self.exerciseTime = try { () throws in
            let timeInterval = try value.decode(Double.self, forKey: .exerciseTime)
            return Date(timeIntervalSince1970: timeInterval)
        }()
        self.calorie = try value.decode(Int.self, forKey: .calorie)
        self.power = try value.decode(ExercisePower.self, forKey: .power)
        self.description = try value.decode(String.self, forKey: .description)
        self.imageURLs = try value.decode([URL].self, forKey: .imageURLs)
    }
}

struct ExerciseCategory {
    let id: String
    let name: String
    let description: String
    let exerciseNames: [String]
}

extension ExerciseCategory: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case exerciseNames = "exercise_names"
    }
}

enum ExercisePower: String, Codable {
    case weak, normal, strong
}
