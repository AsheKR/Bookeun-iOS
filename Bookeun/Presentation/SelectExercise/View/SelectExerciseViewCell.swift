//
//  SelectExerciseViewCell.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

protocol SelectExerciseViewCellDelegate: class {
    func didTap(_ exercise: Exercise?)
}

class SelectExerciseViewCell: UICollectionViewCell, Nameable {
    
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var titleContainerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    @IBOutlet private weak var exerciseImageView: UIImageView!
    @IBOutlet private var gradeViews: [UIView]!
    @IBOutlet weak var checkButton: UIButton!
    
    var exercise: Exercise?
    var checked: Bool = false
    
    weak var delegate: SelectExerciseViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleContainerView.layer.cornerRadius = 25.0
        contentContainerView.layer.cornerRadius = 25.0
        contentContainerView.layer.borderWidth = 2.0
        contentContainerView.layer.borderColor = UIColor.black.cgColor
        
        gradeViews.forEach { $0.layer.cornerRadius = $0.bounds.height / 2 }
    }
    
    @IBAction private func didTap(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.didTap(exercise)
    }
    
    func setExercise(_ exercise: Exercise, checked: Bool) {
        self.exercise = exercise
        checkButton.isSelected = checked
        
        nameLabel.text = exercise.name
        durationLabel.text = "\(exercise.exerciseTime ?? 0) 분"
        calorieLabel.text = "\(exercise.calorie ?? 0) 칼로리"
        if let imageURL = exercise.imageURLs.first, let url = URL(string: imageURL.url) {
            exerciseImageView.kf.setImage(with: url)
        }
    }
}
