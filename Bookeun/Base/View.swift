//
//  View.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        attribute()
        layout()
    }

    func attribute() {}
    
    func layout() {}

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
