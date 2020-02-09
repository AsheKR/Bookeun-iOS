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
    
    let disposeBag = DisposeBag()
    let synthesizer = AVSpeechSynthesizer()
    var book: Book?
    var review: String?
    
    required init(view: BreakeTimeViewController) {
        self.view = view
    }
    
    func setBook(_ book: Book) {
        self.book = book
    }
    
    func viewDidLoad() {
        guard let book = book else {
            view.showErrorView()
            return
        }
        
        view.setBookTitleAndAuthor(title: book.name, author: book.author.name)
        
        Repo.shared.book.getBookReviewList(isbn: book.isbn)
            .map { $0.randomElement() }
            .map { $0?.content ?? "이런.. 이 책에 리뷰가 없어요 ㅠㅠ"}
            .catchErrorJustReturn("오류가 발생했어요")
            .subscribe(onSuccess: { [weak self] review in
                self?.review = review
                self?.view.setReview(review)
            })
            .disposed(by: disposeBag)
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
