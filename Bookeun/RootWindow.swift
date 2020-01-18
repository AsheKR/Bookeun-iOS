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
//        self.rootViewController = TrainerSelectViewController()
        guard let registerBookViewController = UIStoryboard(name: "RegisterBookViewController", bundle: nil).instantiateInitialViewController() as? RegisterBookViewController else {
            fatalError("rootViewController")
        }
        self.rootViewController = registerBookViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
