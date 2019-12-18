//
//  BreakeTimePresenter.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/12/16.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation

class BreakeTimePresenter: PresenterProtocol {
    typealias View = BreakeTimeViewController
    unowned let view: BreakeTimeViewController
    
    let synthesizer = AVSpeechSynthesizer()
    var book: Book?
    var review: String?
    
    required init(view: BreakeTimeViewController) {
        self.view = view
    }
    
    func setBook(_ book: Book) {
        self.book = book
        self.review = book.reviews.randomElement()
    }
    
    func viewDidLoad() {
        guard let book = book, let review = review else {
            view.showErrorView()
            return
        }
        
        view.setBookTitleAndAuthor(title: book.name, author: book.author)
        view.setReview(review)
    }
    
    func didTapReadingButton() {
        guard let review = review else {
            view.showErrorView()
            return
        }
        
        if synthesizer.isSpeaking {
            return
        }
        
        let utterance = AVSpeechUtterance(string: review).then {
            $0.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        }
        synthesizer.speak(utterance)
    }
}
