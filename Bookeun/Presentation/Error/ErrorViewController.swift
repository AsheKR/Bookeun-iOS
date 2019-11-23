//
//  ErrorViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import SnapKit
import Then

class ErrorViewController: ViewController {
    let errorView = ErrorView()

    override func layout() {
        view.addSubview(errorView)

        errorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func initialize() {
        self.do {
            $0.modalPresentationStyle = .overFullScreen
            $0.modalTransitionStyle = .crossDissolve
        }
    }
}
