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
    // 어떤 운동을 선택했는지 확인하기 위한 index
    var exerciseIndex: Int = 0
    
    var secondTimer: Timer!
    var readyCount: Int = 3
    var timerCount: Int = 20
    var exerciseImageIndex = 0
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
    
    var defaultImageURL: URL? {
        return URL(string: exerciseList[exerciseIndex].exercise.imageURLs[0].url)
    }
    
    func start() {
        setExerciseList()
        applyCurrentExercise()
//        startTimer()
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
        view.setExerciseImage(defaultImageURL)
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
        startTimer()
    }
    
    func explain(show: Bool) {
        if show {
            isExplainState = true
        } else {
            isExplainState = false
        }
    }
    
    func explainText(_ index: Int) -> String {
        guard index < exerciseList[exerciseIndex].exercise.explainList.count else {
            return ""
        }
        return exerciseList[exerciseIndex].exercise.explainList[index]
    }
    
    // MARK: - Objc
    
    @objc private func actionPerSecond(_ sender: Timer) {
        print("action per second , readyCount: \(readyCount) , exerciseImageIndex: \(exerciseImageIndex)")
        let exercise = exerciseList[exerciseIndex].exercise
        
        if isReadyState {
            view.showReadyView(readyCount)
            readyCount -= 1
            if readyCount < 0 {
                readyCount = 3
                isReadyState = false
            }
        } else {
            // Exercise Images
            if exerciseImageIndex == exercise.imageURLs.count {
                exerciseImageIndex = 0
            }
            if let imageURL = URL(string: exercise.imageURLs[exerciseImageIndex].url) {
                view.setExerciseImage(imageURL)
            }
            exerciseImageIndex += 1
            
            // view.showTimer
            timerCount -= 1
            
            if timerCount == 0 {
                // END Phase
                secondTimer.invalidate()
                view.setExerciseImage(defaultImageURL)
            }
        }
    }
}
