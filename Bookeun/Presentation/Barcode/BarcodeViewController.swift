//
//  BarcodeViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift

class BarcodeViewController: EmptyViewController {
    let barcodeView = BarcodeView(
        barcodeGuideSize: .init(width: 250, height: 250),
        qrcodeGuideSize: .init(width: UIScreen.main.bounds.width + 2, height: 250)
    )
    let disposeBag = DisposeBag()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barcodeView.currentCode
            .distinctUntilChanged()
            .bind(onNext: { [weak self] code in
                guard let view = UIStoryboard(name: "RegisterBookViewController", bundle: nil).instantiateInitialViewController() as? RegisterBookViewController else {
                    return
                }
                view.bookISBMCode = code
                self?.present(view, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        barcodeView.start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        barcodeView.stop()
    }
    
    override func initialize() {
        self.modalPresentationStyle = .fullScreen
    }

    override func attribute() {
        barcodeView.do {
            $0.initialize()
        }

        titleLabel.do {
            $0.text = """
            바코드로 책을
            등록해 주세요
            """
            $0.textAlignment = .center
            $0.numberOfLines = 2
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 32, weight: .bold)
        }

        descriptionLabel.do {
            $0.text = "안쪽 가이드라인에 책 바코드를 맞춰주세요 "
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 14)
        }

        backButton.do {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .white
            $0.setImage(#imageLiteral(resourceName: "btnBack.pdf").withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    override func layout() {
        view.addSubviews(barcodeView, titleLabel, descriptionLabel, backButton)

        barcodeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(barcodeView.coverView1.snp.bottom).offset(-70)
            $0.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(barcodeView.coverView2.snp.top).offset(25)
            $0.centerX.equalToSuperview()
        }

        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.left.equalToSuperview().offset(15)
            $0.height.equalTo(30)
        }
    }
}
