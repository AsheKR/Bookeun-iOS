//
//  BookeunAPI.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import Moya

enum BookeunAPI {
    case getTrainers
    case getTrainer(id: String)
    
    case getExerciseCategoryList
    
    case getExerciseList
    case getExerciseListWithCategory(categoryID: String)
    case getExercise(id: String)
    
    case getBook(isbn: String)
    case getBookReviewList(isbn: String)
}

extension BookeunAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://api.book.ashe.kr/")!
    }
    
    var path: String {
        switch self {
        case .getTrainers:
            return "v1/trainers"
        case .getTrainer(let id):
            return "v1/trainers/\(id)"
        case .getExerciseCategoryList:
            return "v1/exercise_categories"
        case .getExerciseList:
            return "v1/exercises"
        case .getExerciseListWithCategory(let categoryID):
            return "v1/exercise_categories/\(categoryID)"
        case .getExercise(let id):
            return "v1/exercises/\(id)"
        case .getBook(let isbn):
            return "v1/books/\(isbn)"
        case .getBookReviewList(let isbn):
            return "v1/books/\(isbn)/reviews"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task { .requestPlain }
    
    var sampleData: Data { Data() }
    
    var headers: [String: String]? { nil }
}
