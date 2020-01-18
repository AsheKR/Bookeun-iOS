//
//  RegisterBookViewController.swift
//  Bookeun
//
//  Created by Hyeontae on 2020/01/18.
//  Copyright © 2020 Lizardmon. All rights reserved.
//

import UIKit

class RegisterBookViewController: ViewController<RegisterBookPresenter> {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleWrapperView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentWrapperView: UIView!
    @IBOutlet weak var bottomConformButton: UIButton!
    @IBOutlet weak var contentBookLabel: UILabel!
    @IBOutlet weak var contentWriterLabel: UILabel!
    @IBOutlet weak var contentPageLabel: UILabel!
    @IBOutlet weak var contentWeightLabel: UILabel!
    @IBOutlet weak var contentPriceLabel: UILabel!
    
    var byungChansLove: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRxContent()
        presenter.getBookData(byungChansLove)
    }
    
    override func attribute() {
        backButton.do {
            $0.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        }
        titleWrapperView.do {
            $0.layer.cornerRadius = 8.0
        }
        
        contentImageView.do {
            $0.layer.cornerRadius = 12.0
        }
        
        contentWrapperView.subviews.filter {
            let result = $0 is UIImageView
            return !result
        }.forEach { view in
            view.layer.borderColor = UIColor(red: 215/256, green: 215/256, blue: 215/256, alpha: 1.0).cgColor
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 16.0
        }
        
        bottomConformButton.do {
            $0.layer.cornerRadius = 22.0
            $0.addTarget(self, action: #selector(didTapConformButton(_:)), for: .touchUpInside)
        }
    }
    
    func setupRxContent() {
        // Rx code... sorry
//        use setContent(_:) code
    }
    
    func setContent(_ book: Book) {
        contentImageView.kf.setImage(with: book.coverImageURL)
        bookTitleLabel.text = book.name
        contentBookLabel.text = book.name
        contentWriterLabel.text = book.author
        contentPageLabel.text = "\(book.page)page"
        contentWeightLabel.text = "\(book.weight)g"
        contentPriceLabel.text = "\(book.usedPrice)원"
    }
    
    func presentErrorView() {
        present(ErrorViewController(), animated: true, completion: nil)
    }
    
    @objc private func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapConformButton(_ sener: UIButton) {
        presenter.storeBook()
    }
}
