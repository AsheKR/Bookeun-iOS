//
//  Presenter.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift

class Presenter<View: AnyObject>: PresenterProtocol {
    typealias View = View
    
    let disposeBag = DisposeBag()
    
    unowned let view: Presenter.View
    
    required init(view: View) { self.view = view }
}

protocol PresenterProtocol {
    associatedtype View
    
    var view: View { get }
    
    init(view: View)
}

extension PresenterProtocol {
    static func create(_ object: AnyObject) -> Self {
        guard let view = object as? View else {
            fatalError("""
            올바르지 않은 ViewTYPE이 인자로 들어왔습니다.
            원하는 ViewTYPE: \(View.self)
            현재 들어온 ViewTYPE: \(type(of: object))
            """)
        }
        return .init(view: view)
    }
}
