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
//<<<<<<< HEAD
//
//        self.rootViewController = EmptyViewController()
//
//        Repo.shared.exercise.getExerciseList()
//            .map { list in
//                list.map { exc in ExerciseWithCount.init(exercise: exc, count: 3) }
//            }
//            .subscribe(onSuccess: { [unowned self] list in
//                Store.share.setExerciseList(list)
//                self.rootViewController = UIStoryboard(name: "ExerciseViewController", bundle: nil).instantiateInitialViewController() as! ExerciseViewController
//            })
//=======

        // TODO: 초기뷰 변경 필요!
        let viewController = UIStoryboard(name: SelectExerciseViewController.storyboardName, bundle: nil).instantiateViewController(withIdentifier: SelectExerciseViewController.identifier)
        let navigation = UINavigationController(rootViewController: viewController)
        self.rootViewController = navigation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
