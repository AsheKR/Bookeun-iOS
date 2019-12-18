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

class ErrorViewController: EmptyViewController {
    let errorView = ErrorView()
    
    override func attribute() {
        self.do {
            $0.view.backgroundColor = .clear
        }
    }

    override func layout() {
        view.addSubview(errorView)

        errorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func initialize() {
        self.do {
            $0.modalPresentationStyle = .overCurrentContext
            $0.modalTransitionStyle = .crossDissolve
        }
    }
}
