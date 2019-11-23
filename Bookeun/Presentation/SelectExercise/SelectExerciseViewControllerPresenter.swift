//
//  SelectExerciseViewControllerPresenter.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift

class SelectExerciseViewControllerPresenter: PresenterProtocol {
    
    typealias View = SelectExerciseViewController
    
    let view: View
    
    required init(view: View) { self.view = view }
    
    let disposeBag = DisposeBag()
    
    var exerciseList: [Exercise]?
    var categoryList: [ExerciseCategory]?
    
    private func fetchData(categoryList: [ExerciseCategory], exerciseList: [Exercise]) {
        self.categoryList = categoryList
        self.exerciseList = exerciseList
        
        let filteredExerciseList = exerciseList.filter({ $0.id == categoryList.first?.id })
        view.update(categoryList: categoryList, exerciseList: filteredExerciseList)
    }

    func request() {
        Single.zip(Repo.shared.exercise.getExerciseCategoryList(), Repo.shared.exercise.getExerciseList()).debug()
            .subscribe(onSuccess: fetchData, onError: view.presentErrorView)
            .disposed(by: disposeBag)
    }
    
    func filterData(_ category: ExerciseCategory) -> [Exercise] {
        return exerciseList?.filter({ $0.category.id == category.id }) ?? []
    }
}
