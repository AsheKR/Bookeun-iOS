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
    var timerCount: Int = 6
    var exerciseImageIndex = 0
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
        self.exerciseList = list
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
    
    // MARK: - Objc
    
    func exerciseTimer() {
        let exercise = exerciseList[exerciseIndex].exercise
        // Exercise Images
        if exerciseImageIndex == exercise.imageURLs.count {
            exerciseImageIndex = 0
        }
        if exerciseImageIndex < 3 {
            // 0 1 2
            // 0 2 4
            setExerciseImage(exercise.imageURLs[exerciseImageIndex*2].url)
        } else {
            // 3 4 5
            // 0 2 4
            setExerciseImage(exercise.imageURLs[(exerciseImageIndex-3)*2].url)
        }
        exerciseImageIndex += 1
        
        // Timer
        view.setTimerCount(timerCount)
        timerCount -= 1
        
        if timerCount < 0 { // END Phase
            secondTimer.invalidate()
            timerCount = 6
            setExerciseImage(currentExerciseImageURLString)
            view.hideTimerView(true)
            let endViewController = BreakeTimeViewController()
            let googleBook = Book(id: 0, name: "구글의 미래", coverImageURL: URL(string: "https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/57wZ/image/E8uIYmuJPC_iTWKhJMl3Clf2rLg.jpg")!, author: "author", publisher: "publisher", weight: 10.0, page: 100, grade: 100, reviews: ["갓글 역시 미쳐따 나는 구글에 가고 말꺼야 파이리 짱이야", "갓글 역시 미쳐따 나는 구글에 가고 말꺼야 파이리 짱이야"], salePrice: 1000.0, usedPrice: 2000.0)
            endViewController.modalPresentationStyle = .fullScreen
            endViewController.presenter.setBook(googleBook)
            view.present(endViewController, animated: true, completion: nil)
        }
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
