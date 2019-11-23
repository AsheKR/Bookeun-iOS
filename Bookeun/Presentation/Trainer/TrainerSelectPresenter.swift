//
//  TrainerSelectPresenter.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TrainerSelectPresenter: PresenterProtocol {
    typealias View = TrainerSelectViewController
    
    let disposeBag = DisposeBag()
    
    unowned let view: TrainerSelectViewController
    
    required init(view: View) { self.view = view }
    
    let trainers = PublishRelay<[Trainer]>()
    
    func getTrainers() {
        Repo.shared.trainer.getTrainers()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: trainers.accept, onError: { [weak view] _ in view?.presentErrorView() }
            )
            .disposed(by: disposeBag)
    }
}
