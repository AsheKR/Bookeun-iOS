//
//  ExercisePresenter.swift
//  Bookeun
//
//  Created by Hyeontae on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

class ExercisePresenter {
    unowned let view: ExerciseViewController
    let exercise: Exercise
    
    init(_ view: ExerciseViewController, _ exercise: Exercise) {
        self.view = view
        self.exercise = exercise
    }
    
    func ready() {
        // get image
        view.exerciseImage([])
        
    }
}
