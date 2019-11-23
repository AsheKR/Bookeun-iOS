//
//  ExerciseViewController.swift
//  Bookeun
//
//  Created by Hyeontae on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import Then

class ExerciseViewController: ViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exerciseGuideImageView: UIImageView!
    @IBOutlet weak var exerciseExplainLabel: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    // MARK: - Property
    var presenter: ExercisePresenter!
    var timer: Timer?
    // MARK: - Method (override)
    override func attribute() {
        readyButton.do {
            $0.layer.cornerRadius = 22.5
            $0.addTarget(presenter, action: #selector(didTapReadyButton(_:)), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        print("viewDidLoad")
    }
    // MARK: - Method
    
    @objc func didTapReadyButton(_ sender: UIButton) {
        self.presenter.ready()
    }
    
    func exerciseImage(_ images: [UIImage]) {
        
    }
}
