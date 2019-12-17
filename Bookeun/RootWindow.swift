//
//  RootWindow.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/21.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class RootWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.rootViewController = EmptyViewController()
        
        Repo.shared.exercise.getExerciseList()
            .map { list in
                list.map { exc in ExerciseWithCount.init(exercise: exc, count: 3) }
            }
            .subscribe(onSuccess: { [unowned self] list in
                Store.share.setExerciseList(list)
                self.rootViewController = UIStoryboard(name: "ExerciseViewController", bundle: nil).instantiateInitialViewController() as! ExerciseViewController
            })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
