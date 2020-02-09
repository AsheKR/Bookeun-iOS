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
    var timerCount: Int = 0
    var exerciseImageIndex = 0
    var isExerciseImageOrderingPositive = true
    var isReadyState: Bool = false {
        didSet {
            view.hideReadyView(!isReadyState)
        }
    }
    var isExplainState: Bool = false {
        didSet {
            view.hideExplainView(!isExplainState)
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
        exerciseList = list
        setTimerCount()
    }
    
    func setCurrentExercise() {
        view.setExercise(exerciseList[exerciseIndex].exercise)
        setExerciseImage(currentExerciseImageURLString)
    }
    
    func startTimer() {
        secondTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionPerSecond(_:)), userInfo: nil, repeats: true)
    }
    
    func start() {
        isReadyState = true
        startTimer()
    }
    
    func showExplain(_ show: Bool) {
        isExplainState = show
    }
    
    func explainText(_ index: Int) -> String {
        guard index < exerciseList[exerciseIndex].exercise.explainList.count else {
            return "영혼을 담아서 책을 천천히 들어 올리고 내립니다."
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
    
    func setTimerCount() {
        guard let timePerExercise = exerciseList[exerciseIndex].exercise.exerciseTime else {
            view.presentErrorView()
            return
        }
//        timerCount = exerciseList[exerciseIndex].count * timePerExercise * 60
        timerCount = exerciseList[exerciseIndex].count * timePerExercise * 5
    }
    
    func exerciseTimer() {
        // Exercise Images
        let exercise = exerciseList[exerciseIndex].exercise
        setExerciseImage(exercise.imageURLs[exerciseImageIndex].url)
        
        if isExerciseImageOrderingPositive {
            exerciseImageIndex += 1
        } else {
            exerciseImageIndex -= 1
        }
        
        let imageMaxIndex = exercise.imageURLs.count - 1
        if exerciseImageIndex == 0 || exerciseImageIndex == imageMaxIndex {
            isExerciseImageOrderingPositive.toggle()
        }
       
        // Timer
        view.setTimerCount(timerCount)
        timerCount -= 1
        
        if timerCount < 0 {
            endOfExerciseSet()
        }
    }
    
    func endOfExerciseSet() {
        secondTimer.invalidate()
        setExerciseImage(currentExerciseImageURLString)
        view.hideTimerView(true)
        guard let book = Store.share.book else {
            view.presentErrorView()
            return
        }
        if exerciseIndex == exerciseList.count - 1 {
            showResultView()
        } else {
            showBreakTimeView(with: book)
        }
    }
    
    func showBreakTimeView(with book: Book) {
        let breaTimekView = BreakeTimeViewController()
        breaTimekView.presenter.setBook(book)
        breaTimekView.delegate = self
        view.present(breaTimekView, animated: true, completion: nil)
    }
    
    func showResultView() {
        view.present(ResultViewController(), animated: true, completion: nil)
    }
    
    @objc private func actionPerSecond(_ sender: Timer) {
        if isReadyState {
            view.showReadyCount(readyCount)
            readyCount -= 1
            if readyCount < 0 {
                readyCount = 3
                isReadyState = false
                view.hideTimerView(false)
                exerciseTimer()
            }
        } else {
            exerciseTimer()
        }
    }
}

extension ExercisePresenter: BreakDelegate {
    func didEndBreak() {
        exerciseIndex += 1
        exerciseImageIndex = 0
        setCurrentExercise()
        setTimerCount()
    }
}
