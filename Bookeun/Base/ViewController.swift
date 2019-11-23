//
//  ViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/21.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class ViewController<P: PresenterProtocol>: UIViewController, Nameable {
    private(set) lazy var presenter: P = { P(view: self as! P.View) }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        attribute()
        layout()
    }

    func attribute() {}

    func layout() {}

    func initialize() {}
}
