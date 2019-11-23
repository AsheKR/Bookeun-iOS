//
//  NoTrainerCell.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/24.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import Then

class NoTrainerCell: UICollectionViewCell, Nameable {
    let titleLabel = UILabel()
    let stageImageView = UIImageView()
    
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
        
        titleLabel.do {
            $0.text = "맘에 드는 트레이너가 없다."
            $0.font = .systemFont(ofSize: 20)
            $0.textColor = .gray
        }
        
        stageImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = #imageLiteral(resourceName: "StageIcon")
        }
    }
    
    func layout() {
        addSubviews(titleLabel, stageImageView)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        stageImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(265)
            $0.height.equalTo(36)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
}
