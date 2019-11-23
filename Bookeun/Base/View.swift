//
//  View.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class View<P: PresenterProtocol>: UIView {
    private(set) var presenter: P!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.presenter = P(view: self as! P.View)
        
        attribute()
        layout()
    }

    func attribute() {}
    
    func layout() {}
}
