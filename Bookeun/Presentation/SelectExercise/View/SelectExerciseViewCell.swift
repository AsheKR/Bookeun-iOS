//
//  SelectExerciseViewCell.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class SelectExerciseViewCell: UICollectionViewCell, Nameable {
    
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var titleContainerView: UIView!
    @IBOutlet private weak var checkButton: UIButton!
    @IBOutlet private var gradeViews: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleContainerView.layer.cornerRadius = 25.0
        contentContainerView.layer.cornerRadius = 25.0
        contentContainerView.layer.borderWidth = 2.0
        contentContainerView.layer.borderColor = UIColor.black.cgColor
        
        gradeViews.forEach({ $0.layer.cornerRadius = $0.bounds.height / 2 })
    }
    
    @IBAction private func actionSelecte(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
