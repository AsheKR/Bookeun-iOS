//
//  SubResultView.swift
//  Bookeun
//
//  Created by 이병찬 on 2020/01/18.
//  Copyright © 2020 Lizardmon. All rights reserved.
//

import UIKit
import SnapKit
import Then

class SubResultView: EmptyView {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let resultLabel = UILabel()
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        imageView.image = image
    }
    
    func setResult(_ value: String, unit: String) {
        resultLabel.text = "\(value) \(unit)"
    }
    
    override func attribute() {
        self.do {
            $0.backgroundColor = .iceTwo
            $0.layer.cornerRadius = 22.5
            $0.clipsToBounds = true
        }
        
        [titleLabel, resultLabel].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        resultLabel.do {
            $0.textAlignment = .right
        }
        
        imageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func layout() {
        addSubviews(titleLabel, imageView, resultLabel)
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.width.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.centerY.equalToSuperview()
        }
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 0), for: .horizontal)
        
        resultLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-24)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
