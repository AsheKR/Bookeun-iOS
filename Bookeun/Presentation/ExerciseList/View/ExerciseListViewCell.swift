//
//  ExerciseListViewCell.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 24/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

protocol ExerciseListViewCellDelegate: class {
    func didUpdateDuration(oldCount: Int, newCount: Int, time: Int, at index: Int?)
}

class ExerciseListViewCell: UITableViewCell, Nameable {

    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var exerciseLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var countContainerView: UIView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var totalDurationContainerView: UIView!
    @IBOutlet private weak var totalDurationLabel: UILabel!
    
    var index: Int?
    
    weak var delegate: ExerciseListViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentContainerView.layer.cornerRadius = contentContainerView.bounds.height / 2
        contentContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        countContainerView.layer.cornerRadius = countContainerView.bounds.height / 2
        countContainerView.layer.borderWidth = 1.0
        countContainerView.layer.borderColor = #colorLiteral(red: 0, green: 0.9829525352, blue: 0.6782153249, alpha: 1).cgColor
        totalDurationContainerView.layer.cornerRadius = totalDurationContainerView.bounds.height / 2
        totalDurationContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    private func makeTime() -> Int {
        let timeText = timeLabel.text?.split(separator: "분").first ?? ""
        return Int(timeText) ?? 1
    }
    
    private func updateTotalDuration(_ count: Int) {
        let time = makeTime()
        totalDurationLabel.text = "총 \(count * time)분"
    }
    
    @IBAction private func actionTapButton(_ sender: UIButton) {
        if let countText = countLabel.text, let count = Int(countText) {
            var newCount: Int = 0
            if sender.tag == 1111 {
                newCount = count < 2 ? 1 : count - 1
            } else if sender.tag == 2222 {
                newCount = count + 1
            }
            countLabel.text = "\(newCount)"
            updateTotalDuration(newCount)
            
            delegate?.didUpdateDuration(oldCount: count, newCount: newCount, time: makeTime(), at: index)
        }
    }
    
    func setExercise(_ exercise: Exercise, at index: Int) {
        self.index = index
        
        categoryLabel.text = exercise.category.name
        exerciseLabel.text = exercise.name
        timeLabel.text = "\(exercise.exerciseTime ?? 2)분"
        updateTotalDuration(3)
    }
}
