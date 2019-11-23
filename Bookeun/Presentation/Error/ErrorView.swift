//
//  ErrorView.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import SnapKit
import Then

class ErrorView: EmptyView {
    let titleLabel = UILabel()
    let coverButton = UIButton()

    @objc func exitApplication() {
        exit(0)
    }

    override func attribute() {
        self.do {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }

        titleLabel.do {
            let lineSpacingStyle = NSMutableParagraphStyle()
            lineSpacingStyle.lineSpacing = 20
            $0.attributedText = NSAttributedString(
                string: """
                앗!
                저런
                안타깝네요.
                """,
                attributes: [
                    .foregroundColor: UIColor.white,
                    .paragraphStyle: lineSpacingStyle
                ]
            )
            $0.font = .systemFont(ofSize: 80, weight: .bold)
            $0.adjustsFontSizeToFitWidth = true
            $0.numberOfLines = 3
        }

        coverButton.do {
            $0.addTarget(self, action: #selector(exitApplication), for: .touchUpInside)
        }
    }

    override func layout() {
        addSubviews(titleLabel, coverButton)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(100)
            $0.left.equalToSuperview().offset(32)
        }

        coverButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
