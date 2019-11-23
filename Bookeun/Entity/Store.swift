//
//  Store.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 24/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

class Store {
    static let share = Store()
    
    private(set) var trainer: Trainer?
    private(set) var exerciseList: [ExerciseWithCount]?
    private(set) var bookList: [Book]?
    
    func setTrainer(_ trainer: Trainer) {
        self.trainer = trainer
    }
    
    func setExerciseList(_ exerciseList: [ExerciseWithCount]) {
        self.exerciseList = exerciseList
    }
    
    func setBookList(_ bookList: [Book]) {
        self.bookList = bookList
    }
}
