//
//  ExercisePresenter.swift
//  Bookeun
//
//  Created by Hyeontae on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class ExercisePresenter: PresenterProtocol {
    
    unowned let view: ExerciseViewController
    let exercise: Exercise
    
    var countTimer: Timer!
    var timerCount: Int = 0
    var readyCount: Int = 3
    var isReadyState: Bool = false {
        didSet {
            view.readyView(hide: !isReadyState)
        }
    }
    var isExplainState: Bool = false {
        didSet {
            view.explainView(hide: !isExplainState)
        }
    }
    
    init(_ view: ExerciseViewController, _ exercise: Exercise) {
        self.view = view
        self.exercise = exercise
    }
    
    func setExerciseInformation() {
        // TODO: ADD Set
        view.setName(exercise.name, exercise.name)
    }
    
    func getImages() {
        // image 를 받은 후
        countTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionPerSecond(_:)), userInfo: nil, repeats: true)
    }
    
    func ready() {
        isReadyState = true
    }
    
    func explain() {
        isExplainState = true
    }
    
    func hideExplain() {
        isExplainState = false
    }
    
    func explainText(_ index: Int) -> String {
        guard index < exercise.explainList.count else {
            return ""
        }
        return exercise.explainList[index]
    }
    
    // MARK: - Objc
    
    @objc private func actionPerSecond(_ sender: Timer) {
        if !isReadyState {
            guard timerCount > 0 else {
                return
            }
            // 이미지 변경
            if timerCount < exercise.imageURLs.count {
                timerCount += 1
            } else {
                timerCount = 0
            }
            view.showMainImage(exercise.imageURLs[timerCount])
        } else {
            view.showReadyView(readyCount)
            readyCount -= 1
            if readyCount < 0 {
                readyCount = 3
                isReadyState = false
            }
        }
    }
}
