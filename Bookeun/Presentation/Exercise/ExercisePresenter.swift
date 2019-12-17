//
//  ExercisePresenter.swift
//  Bookeun
//
//  Created by Hyeontae on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import RxSwift

class ExercisePresenter: PresenterProtocol {
    typealias View = ExerciseViewController
    unowned let view: ExerciseViewController
    required init(view: View) { self.view = view }
    
    let disposeBag = DisposeBag()
    var exerciseList: [ExerciseWithCount]!
    
    var secondTimer: Timer!
    var exerciseIndex: Int = 0
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
    
    func start() {
        setExerciseList()
        applyCurrentExercise()
        startTimer()
    }
    
    func setExerciseList() {
        guard let list = Store.share.exerciseList else {
            view.presentErrorView()
            return
        }
        self.exerciseList = list
    }
    
    func applyCurrentExercise() {
        view.setExercise(exerciseList[exerciseIndex].exercise)
    }
    
//    func increaseIndex() {
//        let currentExercise = exerciseList[exerciseIndex]
////        view.setName("", "")
////        view.setExercise(currentExercise)
//        exerciseIndex += 1
//    }
    
    func startTimer() {
//        Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] count in
//                let exerciseImageURLs = self.exerciseList[self.exerciseIndex].exercise.imageURLs
//                let currentIndex = (count % exerciseImageURLs.count)
//                self.view.setExerciseImage(exerciseImageURLs[currentIndex])
//            })
//            .disposed(by: disposeBag)
        secondTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionPerSecond(_:)), userInfo: nil, repeats: true)
        
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
        guard index < exerciseList[exerciseIndex].exercise.explainList.count else {
            return ""
        }
        return exerciseList[exerciseIndex].exercise.explainList[index]
    }
    
    // MARK: - Objc
    
    @objc private func actionPerSecond(_ sender: Timer) {
        let exercise = exerciseList[exerciseIndex].exercise
        
        if !isReadyState {
            guard timerCount > 0 else {
                return
            }
            // 이미지 변환
            if timerCount < exercise.imageURLs.count {
                timerCount += 1
            } else {
                timerCount = 0
            }
            if let imageURL = URL(string: exercise.imageURLs[timerCount].url) {
                view.setExerciseImage(imageURL)
            }
            
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
