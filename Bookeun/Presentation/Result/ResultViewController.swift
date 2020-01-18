//
//  ResultViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2020/01/18.
//  Copyright © 2020 Lizardmon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ResultViewController: ViewController<ResultPresenter> {
    let messageLabel = UILabel()
    let messageImageView = UIImageView()
    let trainerImageView = UIImageView()
    let pageInfoPrefixLabel = UILabel()
    let pageInfoContentLabel = UILabel()
    let pageInforContentUnderline = UIView()
    let pageInfoPostfixLabel = UILabel()
    let calorieView = SubResultView(title: "소비칼로리", image: UIImage())
    let knowledgeView = SubResultView(title: "상승한 지식", image: UIImage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = presenter.getMessage()
        
        if let totalBookPage = presenter.getTotalBookPage() {
            pageInfoContentLabel.text = totalBookPage.description
        }
        
        if let calorie = presenter.getCalorie() {
            calorieView.setResult(calorie.description, unit: "칼로리")
        }
        
        let knowledgeNumber = presenter.getKnowledgeNumber()
        knowledgeView.setResult(knowledgeNumber.description, unit: "북근 포인트")
    }
    
    override func attribute() {
        messageLabel.do {
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 28, weight: .bold)
        }
        
        messageImageView.do {
            $0.image = #imageLiteral(resourceName: "ResultMessageBox")
        }
        
        trainerImageView.do {
            $0.image = #imageLiteral(resourceName: "ResultTrainerIcon")
            $0.contentMode = .scaleAspectFit
        }
        
        pageInfoPrefixLabel.do {
            $0.text = "당신이 운동한"
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.numberOfLines = 1
        }
        
        pageInfoContentLabel.do {
            $0.text = "?"
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }
        
        pageInforContentUnderline.do {
            $0.backgroundColor = .black
        }
        
        pageInfoPostfixLabel.do {
            $0.text = "Page의 책은"
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.numberOfLines = 1
        }
    }
    
    override func layout() {
        view.addSubviews(
            messageImageView, messageLabel, trainerImageView,
            pageInfoPrefixLabel, pageInfoContentLabel, pageInforContentUnderline, pageInfoPostfixLabel,
            calorieView, knowledgeView
        )
        
        messageImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(140)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(messageImageView).offset(10)
            $0.left.right.equalTo(messageImageView).inset(20)
            $0.bottom.equalTo(messageImageView).inset(20 + 10)
        }
        
        trainerImageView.snp.makeConstraints {
            $0.top.equalTo(messageImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(pageInfoPrefixLabel.snp.top).offset(-24)
            $0.width.equalTo(trainerImageView.snp.height)
        }
        
        pageInfoPrefixLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY).offset(100)
            $0.left.equalToSuperview().offset(30)
        }
        pageInfoPrefixLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        pageInfoContentLabel.snp.makeConstraints {
            $0.top.equalTo(pageInfoPrefixLabel)
            $0.left.equalTo(pageInfoPrefixLabel.snp.right)
            $0.right.equalTo(pageInfoPostfixLabel.snp.left)
        }
        
        pageInforContentUnderline.snp.makeConstraints {
            $0.left.right.equalTo(pageInfoContentLabel).inset(4)
            $0.bottom.equalTo(pageInfoContentLabel).offset(3)
            $0.height.equalTo(3)
        }
        
        pageInfoPostfixLabel.snp.makeConstraints {
            $0.top.equalTo(pageInfoPrefixLabel)
            $0.right.equalToSuperview().offset(-30)
        }
        pageInfoPostfixLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        calorieView.snp.makeConstraints {
            $0.top.equalTo(pageInfoContentLabel.snp.bottom).offset(60)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        knowledgeView.snp.makeConstraints {
            $0.top.equalTo(calorieView.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
    }
}
