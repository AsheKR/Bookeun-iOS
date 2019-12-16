//
//  BreakeTimeViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/12/15.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class BreakeTimeViewController: ViewController<BreakeTimePresenter> {
    let backButton = UIButton()
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let imageView = UIImageView()
    let reviewView = UIView()
    let reviewTagLabel = UIButton()
    let bookWithAuthorLabel = UILabel()
    let reviewLabel = UILabel()
    let reviewReadingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @objc func readingButtonTapped() {
        presenter.readingButtonTapped()
    }
    
    func setBookTitleAndAuthor(title: String, author: String) {
        bookWithAuthorLabel.text = title + " - " + author
    }
    
    func setReview(_ review: String) {
        reviewLabel.text = review
    }
    
    func showErrorView() {
        present(ErrorViewController(), animated: true, completion: nil)
    }
    
    override func attribute() {
        titleLabel.do {
            $0.text = "조금 쉬어갑시다"
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 35, weight: .bold)
        }
        
        subTitleLabel.do {
            $0.text = "운동하던 책을 잠시 내려놓고..."
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 16)
        }
        
        imageView.do {
            $0.image = #imageLiteral(resourceName: "BreakeTimeTrainerIcon")
            $0.contentMode = .scaleAspectFit
        }
        
        reviewView.do {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = 25
            $0.backgroundColor = .white
            $0.makeShadow()
        }
        
        reviewTagLabel.do {
            $0.isUserInteractionEnabled = false
            $0.setTitle("책 리뷰", for: .normal)
            $0.setTitleColor(.tealishGreen, for: .normal)
            $0.layer.borderColor = UIColor.tealishGreen.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 17
            $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        }
        
        bookWithAuthorLabel.do {
            $0.text = "책 제목"
            $0.numberOfLines = 2
        }
        
        reviewReadingButton.do {
            $0.tintColor = .tealishGreen
            $0.addTarget(self, action: #selector(readingButtonTapped), for: .touchUpInside)
            $0.setImage(#imageLiteral(resourceName: "SpeakingIcon").withRenderingMode(.alwaysTemplate), for: .normal)
            
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }
        
        backButton.do {
            $0.tintColor = .black
            $0.setImage(#imageLiteral(resourceName: "btnBack.pdf").withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    override func layout() {
        view.addSubviews(backButton, titleLabel, subTitleLabel, imageView, reviewView)
        reviewView.addSubviews(reviewTagLabel, bookWithAuthorLabel, reviewLabel, reviewReadingButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.left.equalToSuperview().offset(15)
            $0.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(45)
            $0.bottom.equalTo(reviewView.snp.top).offset(-40)
            $0.width.equalTo(imageView.snp.height)
            $0.centerX.equalToSuperview()
        }
        imageView.setContentHuggingPriority(.init(rawValue: 0), for: .vertical)
        imageView.setContentHuggingPriority(.init(rawValue: 0), for: .horizontal)
        
        reviewView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2.5)
            $0.bottom.equalToSuperview()
        }
        
        reviewTagLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(34)
        }
        reviewTagLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        reviewTagLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        bookWithAuthorLabel.snp.makeConstraints {
            $0.centerY.equalTo(reviewTagLabel)
            $0.left.equalTo(reviewTagLabel.snp.right).offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(bookWithAuthorLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(reviewReadingButton.snp.top).offset(-16)
        }
        
        reviewReadingButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.width.equalTo(70)
            $0.height.equalTo(70)
        }
    }
}
