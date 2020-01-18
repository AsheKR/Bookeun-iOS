//
//  ExerciseListViewControllerPresenter.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift

class ExerciseListViewControllerPresenter: PresenterProtocol {
    
    typealias View = ExerciseListViewController
    
    unowned let view: View
    
    required init(view: ExerciseListViewController) { self.view = view }
    
    let defaultSetCount: Int = 3
    let disposeBag = DisposeBag()
    
    var selectedExerciseList: [ExerciseWithCount] = []
    var exerciseTime: (duration: Int, set: Int) = (0, 0)
    
    func updateTotalDuration() {
        let duration = selectedExerciseList.compactMap({ ($0.exercise.exerciseTime ?? 2) * defaultSetCount })
                                            .reduce(0, +)
        exerciseTime = (duration, defaultSetCount * selectedExerciseList.count)
        
        view.updateTotalDuration(name: selectedExerciseList.compactMap({ $0.exercise.category.name })
                                                            .joined(separator: ","),
                                duration: "\(exerciseTime.duration)분",
                                set: "\(exerciseTime.set)세트")
    }
    
    func updateTotalDuration(oldCount: Int, newCount: Int, time: Int, at index: Int?) {
        
        if let index = index, index < selectedExerciseList.count {
            selectedExerciseList[index].count = newCount
        }
        
        let changed = newCount - oldCount
        exerciseTime.duration += changed * time
        exerciseTime.set += changed
        
        view.updateTotalDuration(name: selectedExerciseList.compactMap({ $0.exercise.category.name })
                                                            .joined(separator: ","),
                                duration: "\(exerciseTime.duration)분",
                                set: "\(exerciseTime.set)세트")
    }
    
    func updateStore() {
        Store.share.setExerciseList(selectedExerciseList)
    }
}
