//
//  BookRepository.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol BookRepository {
    func getBook(isbm: String) -> Single<Book>
    func getBookReviewList(isbm: String) -> Single<[BookReview]>
}

class BookRepositoryImpl: NetworkRepository<BookeunAPI>, BookRepository {
    func getBook(isbm: String) -> Single<Book> {
        provider.rx.request(.getBook(isbm: isbm))
            .filterSuccessfulStatusCodes()
            .map(Book.self)
    }
    
    func getBookReviewList(isbm: String) -> Single<[BookReview]> {
        provider.rx.request(.getBookReviewList(isbm: isbm))
            .filterSuccessfulStatusCodes()
            .map([BookReview].self)
    }
}
