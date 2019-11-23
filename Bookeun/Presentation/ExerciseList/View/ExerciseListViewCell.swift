//
//  ExerciseListViewCell.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 24/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class ExerciseListViewCell: UITableViewCell, Nameable {

    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var exerciseLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var countContainerView: UIView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var totalDurationContainerView: UIView!
    @IBOutlet private weak var totalDurationLabel: UILabel!
    
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
    
    private func updateTotalDuration(_ count: Int) {
        let timeText = timeLabel.text ?? ""
        let time = Int(timeText) ?? 1
        totalDurationLabel.text = "총 \(count * time)분"
    }
    
    @IBAction private func actionTapButton(_ sender: UIButton) {
        if let countText = countLabel.text, let count = Int(countText) {
            var countText: String = ""
            var newCount: Int = 0
            if sender.tag == 1111 {
                newCount = count - 1
                countText = newCount < 1 ? "1" : "\(newCount)"
            } else if sender.tag == 2222 {
                newCount = count + 1
                countText = "\(newCount)"
            }
            countLabel.text = countText
            updateTotalDuration(newCount)
        }
    }
}
