//
//  ResultPresenter.swift
//  Bookeun
//
//  Created by 이병찬 on 2020/01/18.
//  Copyright © 2020 Lizardmon. All rights reserved.
//

import Foundation

class ResultPresenter: PresenterProtocol {
    typealias View = ResultViewController
    
    unowned var view: ResultViewController
    
    required init(view: ResultViewController) {
        self.view = view
    }
    
    func getMessage() -> String {
        let messageList = [
            "차라리 이럴 시간에\n책을 읽는 것은 어떤가요?",
            "형! 정말 진짜 이거 다 했어? 🤭",
            "당신이 지금 들고 있었던\n책 때문에 아마존의 나무는 사라지고 있어요",
            "당신의 쓸데없는 도전에\n박수를👏"
        ]
        return messageList.shuffled().first ?? ""
    }
    
    func getTotalBookPage() -> Int? {
        guard let book = Store.share.book else {
            return nil
        }
        return book.page
    }
    
    func getCalorie() -> Int? {
        guard let excerciseWithCountList = Store.share.exerciseList else {
            return nil
        }
        
        return excerciseWithCountList.reduce(0) { before, data -> Int in
            // 운동 시간 (초) * 총 운동 횟수
            let totalExerciseTime = (data.exercise.exerciseTime ?? 0) * data.count
            // 초당 소모되는 운동 Calorie
            let exerciseCalorie = data.exercise.calorie ?? 0
            // Total 운동한 시간 * 초당 소모되는 운동 Calorie
            return before + (totalExerciseTime * exerciseCalorie)
        }
    }
    
    func getKnowledgeNumber() -> Int {
        return Int.random(in: 10 ... 100)
    }
}
