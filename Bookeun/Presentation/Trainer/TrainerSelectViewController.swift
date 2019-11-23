//
//  TrainerSelectViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class TrainerSelectViewController: ViewController<TrainerSelectPresenter>, UICollectionViewDelegate {
    let progressView = UIView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    lazy var trainersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
    let collectionFlowLayout = UICollectionViewFlowLayout()
    let selectButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    func selectButtonTapped() {
        let selectedCell = trainersCollectionView.visibleCells.first as? TrainerCell
        
        if let trainer = selectedCell?.trainer {
            
//            present(, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        } else {
            presentErrorView()
        }
    }
    
    func presentErrorView() {
        present(ErrorViewController(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        collectionFlowLayout.itemSize = trainersCollectionView.frame.size
        
        presenter.trainers
            .map { $0 + [nil] }
            .bind(to: trainersCollectionView.rx.items) { cv, row, trainer in
                if let trainer = trainer {
                    let cell = cv.dequeueReusableCell(withReuseIdentifier: "TrainerCell", for: .init(row: row, section: 0)) as! TrainerCell
                    cell.setTrainer(trainer)
                    return cell
                } else {
                    return cv.dequeueReusableCell(withReuseIdentifier: "NoTrainerCell", for: .init(row: row, section: 0))
                }
            }
            .disposed(by: disposeBag)
        
        presenter.getTrainers()
    }
    
    override func attribute() {
        titleLabel.do {
            $0.text = "당신의 트레이너는"
            $0.font = .systemFont(ofSize: 32, weight: .bold)
        }
        
        descriptionLabel.do {
            $0.text = "당신의 체형과 비슷한 트레이너를 선택해 주세요"
            $0.font = .systemFont(ofSize: 14)
        }
        
        trainersCollectionView.do {
            $0.register(NoTrainerCell.self, forCellWithReuseIdentifier: "NoTrainer")
            $0.register(TrainerCell.self, forCellWithReuseIdentifier: "Trainer")
        }
        
        selectButton.do {
            $0.setTitle("책 등록으로 넘어가기", for: .normal)
            $0.backgroundColor = .green
            $0.layer.cornerRadius = 23
        }
    }
    
    override func layout() {
        view.addSubviews(progressView, titleLabel, descriptionLabel, trainersCollectionView, selectButton)
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.left.right.equalToSuperview().inset(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        trainersCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(selectButton.snp.top)
        }
        trainersCollectionView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        selectButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(46)
        }
    }
}

extension TrainerSelectViewController {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let trainerCell = cell as? TrainerCell {
            trainerCell.setHighlighted(true)
            selectButton.setTitle("책 등록으로 넘어가기", for: .normal)
        } else {
            // Trainer가 선택되지 않을 때
            selectButton.setTitle("진짜? 아무도 없어요?", for: .normal)
        }
        
        let trainerCell = cell as? TrainerCell
        trainerCell?.setHighlighted(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let trainerCell = cell as? TrainerCell
        trainerCell?.setHighlighted(false)
    }
}
