//
//  TrainerRepository.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol TrainerRepository {
    func getTrainers() -> Single<[Trainer]>
    func getTrainer(id: String) -> Single<Trainer>
}

class TrainerRepositoryImpl: NetworkRepository<BookeunAPI>, TrainerRepository {
    func getTrainers() -> Single<[Trainer]> {
        provider.rx.request(.getTrainers)
            .filterSuccessfulStatusCodes()
            .map([Trainer].self)
    }

    func getTrainer(id: String) -> Single<Trainer> {
        provider.rx.request(.getTrainer(id: id))
            .filterSuccessfulStatusCodes()
            .map(Trainer.self)
    }
}
