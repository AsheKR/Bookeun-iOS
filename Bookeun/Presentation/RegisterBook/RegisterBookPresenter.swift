//
//  RegisterBookPresenter.swift
//  Bookeun
//
//  Created by Hyeontae on 2020/01/18.
//  Copyright © 2020 Lizardmon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterBookPresenter: PresenterProtocol {
    typealias View = RegisterBookViewController
    unowned let view: RegisterBookViewController
    required init(view: View) { self.view = view }
    let disposeBag = DisposeBag()
    var book: Book? = nil
    
    func getBookData(_ isbm: String) {
        Repo.shared.book.getBook(isbm: isbm)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self, weak view] book in
                self?.book = book
                view?.setBook(book)
            }, onError: { [weak view] _ in
                view?.presentErrorView()
            })
            .disposed(by: disposeBag)
    }
    
    func storeBook() {
        guard let book = book else {
            view.presentErrorView()
            return
        }
        Store.share.setBook(book)
    }
}
