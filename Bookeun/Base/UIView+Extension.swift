//
//  UIView+Extension.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
    
    func bringSubviewsToFront(_ views: UIView...) {
        views.forEach(bringSubviewToFront)
    }
    
    /// View에 그림자를 만드는 함수입니다.
    /// 제플린에 표시되는 color, alpha, x, y, blur, spread 값을 각각 입력해주세요
    func makeShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 12, spread: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        if spread != 0 {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
