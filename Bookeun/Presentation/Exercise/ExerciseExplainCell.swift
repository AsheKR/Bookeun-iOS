//
//  ExerciseExplainCell.swift
//  Bookeun
//
//  Created by Hyeontae on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class ExerciseExplainCell: UITableViewCell {
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var explainTextLabel: UILabel!
    
    func setExplain(_ number: Int, _ explain: String) {
        numberLabel.text = String(number)
        explainTextLabel.text = explain
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
