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
    
    @objc func didTapSelectButton() {
        let selectedCell = trainersCollectionView.visibleCells.first as? TrainerCell
        
        if let trainer = selectedCell?.trainer {
            Store.share.setTrainer(trainer)
//            present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: true, completion: nil)
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
        collectionFlowLayout.itemSize = .init(width: UIScreen.main.bounds.width, height: trainersCollectionView.frame.height - 150)
        
        presenter.trainers
            .map { ($0 as [Trainer]) + [nil] }
            .asDriver(onErrorDriveWith: .empty())
            .drive(trainersCollectionView.rx.items) { clv, row, trainer in
                if let trainer = trainer {
                    let cell = clv.dequeueReusableCell(withReuseIdentifier: TrainerCell.identifier, for: .init(row: row, section: 0)) as! TrainerCell
                    cell.setTrainer(trainer)
                    return cell
                } else {
                    return clv.dequeueReusableCell(withReuseIdentifier: NoTrainerCell.identifier, for: .init(row: row, section: 0))
                }
            }
            .disposed(by: disposeBag)
        
        presenter.getTrainers()
    }
    
    override func attribute() {
        titleLabel.do {
            $0.text = "당신의 트레이너는"
            $0.font = .systemFont(ofSize: 32, weight: .bold)
            $0.textColor = .black
        }
        
        descriptionLabel.do {
            $0.text = "당신의 체형과 비슷한 트레이너를 선택해 주세요"
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .black
        }
        
        collectionFlowLayout.do {
            $0.scrollDirection = .horizontal
            $0.sectionInset = .zero
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }
        
        trainersCollectionView.do {
            $0.register(NoTrainerCell.self, forCellWithReuseIdentifier: NoTrainerCell.identifier)
            $0.register(TrainerCell.self, forCellWithReuseIdentifier: TrainerCell.identifier)
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.backgroundColor = .white
        }
        
        selectButton.do {
            $0.setTitle("책 등록으로 넘어가기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            $0.backgroundColor = .brightSeaGreen
            $0.layer.cornerRadius = 23
            $0.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
        }
    }
    
    override func layout() {
        view.addSubviews(progressView, titleLabel, descriptionLabel, trainersCollectionView, selectButton)
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(20)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak trainerCell] in
                trainerCell?.setHighlighted(true)
            }
            selectButton.setTitle("책 등록으로 넘어가기", for: .normal)
        } else {
            // Trainer가 선택되지 않을 때
            selectButton.setTitle("진짜? 아무도 없어요?", for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let trainerCell = cell as? TrainerCell
        trainerCell?.setHighlighted(false)
    }
}
