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
    
    private var exerciseList: [Exercise]?
    private var categoryList: [ExerciseCategory]?
    
    private(set) var filteredExerciseList: [Exercise] = []
    private(set) var selectedExerciseList: [Exercise] = []
    
    private func fetchData(categoryList: [ExerciseCategory], exerciseList: [Exercise]) {
        self.categoryList = categoryList
        self.exerciseList = exerciseList
        
        filteredExerciseList = exerciseList.filter({ $0.category.id == 1 })
        view.update()
    }

    func request() {
        Single.zip(Repo.shared.exercise.getExerciseCategoryList(), Repo.shared.exercise.getExerciseList()).debug()
            .subscribe(onSuccess: fetchData, onError: view.presentErrorView)
            .disposed(by: disposeBag)
    }
    
    func filterData(_ index: Int) {
        filteredExerciseList = exerciseList?.filter({ $0.category.id == index }) ?? []
        view.update()
    }
    
    func updateSelectedExerciseList(_ exercise: Exercise) {
        if let selected = selectedExerciseList.first(where: { $0.id == exercise.id }) {
            selectedExerciseList.removeAll(where: { $0.id == selected.id })
        } else {
            selectedExerciseList.append(exercise)
        }
    }
}
