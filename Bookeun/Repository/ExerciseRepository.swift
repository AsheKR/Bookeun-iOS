//
//  ExerciseRepository.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol ExerciseRepository {
    func getExerciseCategoryList() -> Single<[ExerciseCategory]>
    func getExerciseList() -> Single<[Exercise]>
    func getExerciseListWithCategory(categoryID: String) -> Single<[Exercise]>
    func getExercise(id: String) -> Single<Exercise>
}

class ExerciseRepositoryImpl: NetworkRepository<BookeunAPI>, ExerciseRepository {
    func getExerciseCategoryList() -> Single<[ExerciseCategory]> {
        provider.rx.request(.getExerciseList)
            .filterSuccessfulStatusCodes()
            .map([ExerciseCategory].self)
    }

    func getExerciseList() -> Single<[Exercise]> {
        provider.rx.request(.getExerciseList)
            .filterSuccessfulStatusCodes()
            .map([Exercise].self)
    }

    func getExerciseListWithCategory(categoryID: String) -> Single<[Exercise]> {
        provider.rx.request(.getExerciseListWithCategory(categoryID: categoryID))
            .filterSuccessfulStatusCodes()
            .map([Exercise].self)
    }

    func getExercise(id: String) -> Single<Exercise> {
        provider.rx.request(.getExercise(id: id))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(Exercise.self)
    }
}
