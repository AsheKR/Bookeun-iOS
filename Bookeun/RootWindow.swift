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

        // TODO: 초기뷰 변경 필요!
        let viewController = UIStoryboard(name: SelectExerciseViewController.storyboardName, bundle: nil).instantiateViewController(withIdentifier: SelectExerciseViewController.identifier)
        let navigation = UINavigationController(rootViewController: viewController)
        self.rootViewController = navigation
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
