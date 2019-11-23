//
//  ExerciseListViewController.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class ExerciseListViewController: ViewController<ExerciseListViewControllerPresenter> {
    
    static let storyboardName = "ExerciseList"

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private var menuViews: [UIView]!
    
    override func attribute() {
        menuViews.forEach({ $0.layer.cornerRadius = $0.bounds.height / 2 })
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2
    }
}

extension ExerciseListViewController: UITableViewDelegate {
    
}

extension ExerciseListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseListViewCell.identifier, for: indexPath) as? ExerciseListViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
