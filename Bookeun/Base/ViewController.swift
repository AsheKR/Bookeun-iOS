//
//  ViewController.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/21.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import Then

class ViewController<P: PresenterProtocol>: UIViewController, Nameable {
    private(set) lazy var presenter: P = { P(view: self as! P.View) }()
    
    // 사용하지 않는 뷰에서는 true
    var hiddenNavigationBar: Bool = false
    
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
        setNavigation()
        
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(hiddenNavigationBar, animated: false)
    }

    func attribute() {}

    func layout() {}

    func initialize() {}
    
    private func setNavigation() {
        let backButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btnBack"), style: .plain, target: self, action: #selector(actionBackButton))
        backButtonItem.tintColor = .black
        navigationItem.setLeftBarButton(backButtonItem, animated: false)
        
        navigationController?.navigationBar.do({
            $0.backgroundColor = .clear
            $0.barTintColor = .white
            $0.shadowImage = UIImage()
            $0.isTranslucent = false  
        })
    }
    
    @objc private func actionBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
