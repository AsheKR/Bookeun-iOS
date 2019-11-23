//
//  View.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class View<P: PresenterProtocol>: UIView {
    private(set) lazy var presenter = P.create(self)
    
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

    func attribute() {}
    
    func layout() {}
}
