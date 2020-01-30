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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.updateTotalDuration()
    }
    
    override func attribute() {
        menuViews.forEach { $0.layer.cornerRadius = $0.bounds.height / 2 }
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2
    }
    
    func updateTotalDuration(name: String, duration: String, set: String) {
        categoriesLabel.text = name
        durationLabel.text = duration
        setCountLabel.text = set
    }
    
    @IBAction private func actionNextButton(_ sender: UIButton) {
        presenter.updateStore()
        guard let vc = UIStoryboard(name: "ExerciseViewController", bundle: nil).instantiateInitialViewController() as? ExerciseViewController else {
            present(ErrorViewController(), animated: true, completion: nil)
            return
        }
        present(vc, animated: true, completion: nil)
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
        let exerciseWithCount = presenter.selectedExerciseList[indexPath.row]
        
        cell.delegate = self
        cell.setExercise(exerciseWithCount, at: indexPath.row)
        
        return cell
    }
}

extension ExerciseListViewController: ExerciseListViewCellDelegate {
    
    func didUpdateDuration(oldCount: Int, newCount: Int, time: Int, at index: Int?) {
        presenter.updateTotalDuration(oldCount, newCount, time, at: index)
    }
}
