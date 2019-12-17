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
    @IBOutlet private weak var categoriesLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var setCountLabel: UILabel!
    @IBOutlet private var menuViews: [UIView]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.updateTotalDuration()
    }
    
    override func attribute() {
        menuViews.forEach({ $0.layer.cornerRadius = $0.bounds.height / 2 })
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2
    }
    
    func updateTotalDuration() {
        categoriesLabel.text = presenter.selectedExerciseList.compactMap({ $0.category.name })
                                                            .joined(separator: ",")
        durationLabel.text = "\(presenter.exerciseTime.duration)분"
        setCountLabel.text = "\(presenter.exerciseTime.set)세트"
    }
}

extension ExerciseListViewController: UITableViewDelegate {
    
}

extension ExerciseListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.selectedExerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseListViewCell.identifier,
                                                       for: indexPath) as? ExerciseListViewCell else {
            return UITableViewCell()
        }
        let exercise = presenter.selectedExerciseList[indexPath.row]
        
        cell.delegate = self
        cell.configure(exercise)
        
        return cell
    }
}

extension ExerciseListViewController: ExerciseListViewCellDelegate {
    
    func didUpdateDuration(oldCount: Int, newCount: Int, time: Int) {
        let changed = newCount - oldCount
        presenter.updateTotalDuration(changed: changed, time: time)
    }
}
