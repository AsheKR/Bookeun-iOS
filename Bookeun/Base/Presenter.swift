//
//  Presenter.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import RxSwift

protocol PresenterProtocol {
    associatedtype View
    
    var view: View { get }
    
    init(view: View)
}
