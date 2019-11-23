//
//  TrainerCell.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/24.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import Kingfisher

class TrainerCell: UICollectionViewCell {
    let trainerImageView = UIImageView()
    let stageImageView = UIImageView()
    let nameLabel = UILabel()
    
    var trainer: Trainer?
    
    func setTrainer(_ trainer: Trainer) {
        self.trainer = trainer
        trainerImageView.kf.setImage(with: trainer.imageURL)
        nameLabel.text = trainer.name
    }
    
    func setHighlighted(_ isHighlighted: Bool) {
        if let imageURL = isHighlighted ? trainer?.impactImageURL : trainer?.imageURL {
            trainerImageView.kf.setImage(with: imageURL)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        attribute()
        layout()
    }
    
    func attribute() {
        trainerImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = #imageLiteral(resourceName: "StageIcon")
        }
        
        stageImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        nameLabel.do {
            $0.text = "----"
            $0.font = .systemFont(ofSize: 20)
        }
    }
    
    func layout() {
        addSubviews(trainerImageView, stageImageView, nameLabel)
        
        trainerImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(stageImageView.snp.top).offset(10)
        }
        
        stageImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
        stageImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(stageImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
}
