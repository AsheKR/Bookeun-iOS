//
//  RepositoryContainer.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

/// 사용예시 `Repo.book`
typealias Repo = RepositoryContainer

class RepositoryContainer {
    static let shared: RepositoryContainer = .init()
    private init() {}
    
    lazy private(set) var book: BookRepository = BookRepositoryImpl()
    
    lazy private(set) var exercise: ExerciseRepository = ExerciseRepositoryImpl()
    
    lazy private(set) var trainer: TrainerRepository = TrainerRepositoryImpl()
}
