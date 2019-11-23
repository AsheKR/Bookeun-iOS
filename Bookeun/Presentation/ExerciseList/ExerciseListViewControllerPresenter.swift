//
//  ExerciseListViewControllerPresenter.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

class ExerciseListViewControllerPresenter: PresenterProtocol {
    
    typealias View = ExerciseListViewController
    
    let view: View
    
    required init(view: ExerciseListViewController) { self.view = view }
}
