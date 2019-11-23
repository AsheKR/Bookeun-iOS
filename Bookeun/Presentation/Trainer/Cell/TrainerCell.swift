//
//  TrainerCell.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/24.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import Kingfisher

class TrainerCell: UICollectionViewCell, Nameable {
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
        self.do {
            $0.backgroundColor = .white
        }
        
        trainerImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        stageImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = #imageLiteral(resourceName: "StageIcon")
        }
        
        nameLabel.do {
            $0.text = "----"
            $0.font = .systemFont(ofSize: 20)
            $0.textColor = .black
        }
    }
    
    func layout() {
        addSubviews(stageImageView, trainerImageView, nameLabel)
        
        trainerImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(stageImageView.snp.top).offset(20)
        }
        
        stageImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(265)
            $0.height.equalTo(36)
            $0.bottom.equalToSuperview().offset(-30)
        }
        stageImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(stageImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
}
