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
            view.hideReadyView(hide: !isReadyState)
        }
    }
    var isExplainState: Bool = false {
        didSet {
            view.hideExplainView(hide: !isExplainState)
        }
    }
    
    var currentExerciseImageURLString: String {
        return exerciseList[exerciseIndex].exercise.imageURLs[0].url
    }
    
    // 처음에 시작될때 운동을 View에 보여주는 역할
    func setUpView() {
        setExerciseList()
        setCurrentExercise()
    }
    
    func setExerciseList() {
        guard let list = Store.share.exerciseList else {
            view.presentErrorView()
            return
        }
        self.exerciseList = list
    }
    
    func setCurrentExercise() {
        view.setExercise(exerciseList[exerciseIndex].exercise)
        setExerciseImage(currentExerciseImageURLString)
    }
    
    func startTimer() {
        // TODO: RxSwift
//        Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] count in
//                let exerciseImageURLs = self.exerciseList[self.exerciseIndex].exercise.imageURLs
//                let currentIndex = (count % exerciseImageURLs.count)
//                self.view.setExerciseImage(exerciseImageURLs[currentIndex])
//            })
//            .disposed(by: disposeBag)
        secondTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionPerSecond(_:)), userInfo: nil, repeats: true)
    }
    
    func start() {
        isReadyState = true
        startTimer()
    }
    
    func showExplain(show: Bool) {
        if show {
            isExplainState = true
        } else {
            isExplainState = false
        }
    }
    
    func explainText(_ index: Int) -> String {
        guard index < exerciseList[exerciseIndex].exercise.explainList.count else {
            return "설명이 없습니다."
        }
        return exerciseList[exerciseIndex].exercise.explainList[index]
    }
    
    func setExerciseImage(_ imageURLString: String) {
        guard let imageURL = URL(string: imageURLString) else {
            view.presentErrorView()
            return
        }
        view.setExerciseImage(imageURL)
    }
    
    // MARK: - Objc
    
    @objc private func actionPerSecond(_ sender: Timer) {
        let exercise = exerciseList[exerciseIndex].exercise
        
        if isReadyState {
            view.showReadyCount(readyCount)
            readyCount -= 1
            if readyCount < 0 {
                readyCount = 3
                isReadyState = false
                view.hideTimerView(hide: false)
            }
        } else {
            // Exercise Images
            if exerciseImageIndex == exercise.imageURLs.count {
                exerciseImageIndex = 0
            }
            setExerciseImage(exercise.imageURLs[exerciseImageIndex].url)
            exerciseImageIndex += 1
            
            // Timer
            view.setTimerCount(timerCount)
            timerCount -= 1
            
            if timerCount < 0 {
                secondTimer.invalidate()
                setExerciseImage(currentExerciseImageURLString)
                view.hideTimerView(hide: true)
                // TODO: END Phase
            }
        }
    }
}
