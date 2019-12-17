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
                // MARK: Original
//                self.rootViewController = UIStoryboard(name: "ExerciseViewController", bundle: nil).instantiateInitialViewController() as! ExerciseViewController
                // MARK: Exercise
                guard let viewController = UIStoryboard(name: ExerciseViewController.identifier, bundle: nil).instantiateInitialViewController() else {
                    return
                }
                let exerciseNavigationController = UINavigationController(rootViewController: viewController)
                self.rootViewController = exerciseNavigationController
            })

//        guard let viewController = UIStoryboard(name: ExerciseViewController.identifier, bundle: nil).instantiateInitialViewController() else {
//            return
//        }
//        let navigation = UINavigationController(rootViewController: viewController)
//        self.rootViewController = navigation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
