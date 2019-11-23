//
//  EmptyViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class EmptyViewControllerPresenter: PresenterProtocol {
    typealias View = EmptyViewController
    
    let view: View
    required init(view: View) { self.view = view }
}

typealias EmptyViewController = ViewController<EmptyViewControllerPresenter>
