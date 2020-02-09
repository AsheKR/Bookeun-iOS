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
    func getBook(isbn: String) -> Single<Book>
    func getBookReviewList(isbn: String) -> Single<[BookReview]>
}

class BookRepositoryImpl: NetworkRepository<BookeunAPI>, BookRepository {
    func getBook(isbn: String) -> Single<Book> {
        provider.rx.request(.getBook(isbn: isbn))
            .filterSuccessfulStatusCodes()
            .map(Book.self)
    }
    
    func getBookReviewList(isbn: String) -> Single<[BookReview]> {
        provider.rx.request(.getBookReviewList(isbn: isbn))
            .filterSuccessfulStatusCodes()
            .map([BookReview].self)
    }
}
