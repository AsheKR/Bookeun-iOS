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
    let book = PublishRelay<Book>()
    
    func getBookData(_ isbm: String) {
        Repo.shared.book.getBook(isbm: isbm)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: book.accept, onError: { [weak view] _ in view?.presentErrorView() })
            .disposed(by: disposeBag)
    }
    
    func storeBook() {
        // use presenter.book hear ^^;
//        Store.share.setBookList([book])
    }
}
