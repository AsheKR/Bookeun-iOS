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
    
    static let defaultSetCount: Int = 1
    
    typealias View = ExerciseListViewController
    
    unowned let view: View
    
    required init(view: ExerciseListViewController) { self.view = view }
    
    let disposeBag = DisposeBag()
    
    var selectedExerciseList: [ExerciseWithCount] = []
    var exerciseTime: (duration: Int?, set: Int) = (nil, 0)
    
    func updateTotalDuration() {
        let duration = selectedExerciseList.compactMap({ ($0.exercise.exerciseTime ?? 0) * ExerciseListViewControllerPresenter.defaultSetCount })
                                            .reduce(0, +)
        exerciseTime = (duration, ExerciseListViewControllerPresenter.defaultSetCount * selectedExerciseList.count)
        
        var exerciseDuration: String
        if let duration = exerciseTime.duration {
            exerciseDuration = "\(duration)"
        } else {
            exerciseDuration = "?"
        }
        view.updateTotalDuration(name: selectedExerciseList.map({ $0.exercise.category.name })
                                                            .joined(separator: ","),
                                duration: "\(exerciseDuration)",
                                set: "\(exerciseTime.set)")
    }
    
    func updateTotalDuration(_ oldCount: Int, _ newCount: Int, _ time: Int?, at index: Int?) {
        
        if let index = index, index < selectedExerciseList.count {
            selectedExerciseList[index].count = newCount
        }
        
        let changed = newCount - oldCount
        var durationString: String
        if let duration = exerciseTime.duration, let time = time {
            let value = duration + changed * time
            exerciseTime.duration = value
            durationString = "\(value)"
        } else {
            durationString = "?"
        }
        exerciseTime.set += changed
        
        view.updateTotalDuration(name: selectedExerciseList.map({ $0.exercise.category.name })
                                                            .joined(separator: ","),
                                duration: "\(durationString)",
                                set: "\(exerciseTime.set)")
    }
    
    func updateStore() {
        Store.share.setExerciseList(selectedExerciseList)
    }
}
