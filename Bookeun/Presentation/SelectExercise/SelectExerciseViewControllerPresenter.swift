//
//  SelectExerciseViewControllerPresenter.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

class SelectExerciseViewControllerPresenter: PresenterProtocol {
    
    typealias View = SelectExerciseViewController
    
    let view: View
    
    required init(view: View) { self.view = view }
}
