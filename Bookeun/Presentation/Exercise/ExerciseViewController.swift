//
//  ExerciseViewController.swift
//  Bookeun
//
//  Created by Hyeontae on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit
import Then
import Kingfisher

class ExerciseViewController: ViewController<ExercisePresenter> {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var hideExplainView: UIView!
    @IBOutlet weak var exerciseGuideImageView: UIImageView!
    @IBOutlet weak var explainExerciseButton: UIButton!
    @IBOutlet weak var readyButton: UIButton!
    
    @IBOutlet weak var readyView: UIView!
    @IBOutlet weak var readyLabel: UILabel!
    
    @IBOutlet weak var explainExerciseView: UIView!
    @IBOutlet weak var explainTableView: UITableView!
    @IBOutlet weak var closeExplainButton: UIButton!
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerCountLabel: UILabel!
    
    // MARK: - Common Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setUpView()
    }
    
    override func attribute() {
        hideExplainView.do {
            $0.layer.cornerRadius = 17.0
        }
        explainExerciseButton.do {
            $0.layer.cornerRadius = 22.5
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor(red: 9.0 / 256.0, green: 222.0 / 256.0, blue: 141.0 / 256.0, alpha: 1.0).cgColor
            $0.addTarget(self, action: #selector(didTapExplainButton(_:)), for: .touchUpInside)
        }
        readyButton.do {
            $0.layer.cornerRadius = 22.5
            $0.addTarget(self, action: #selector(didTapReadyButton(_:)), for: .touchUpInside)
        }
        explainTableView.do {
            $0.dataSource = self
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 175.0
        }
        closeExplainButton.do {
            $0.addTarget(self, action: #selector(didTapCloseExplainButton(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Objc
    
    @objc private func didTapExplainButton(_ sender: UIButton) {
        presenter.showExplain(true)
    }
    
    @objc private func didTapReadyButton(_ sender: UIButton) {
        presenter.start()
    }
    
    @objc private func didTapCloseExplainButton(_ sender: UIButton) {
        presenter.showExplain(false)
    }
    
    // MARK: - Custom Method
    
    func hideReadyView(_ hide: Bool) {
        readyView.isHidden = hide
    }
    
    func hideExplainView(_ hide: Bool) {
        explainExerciseView.isHidden = hide
    }
    
    func hideTimerView(_ hide: Bool) {
        timerView.isHidden = hide
    }
    
    // Exercise Basic Info
    func setExercise(_ exercise: Exercise) {
        nameLabel.text = exercise.name
        englishNameLabel.text = exercise.name
    }
    
    func setExerciseImage(_ imageURL: URL) {
        exerciseGuideImageView.kf.setImage(with: imageURL)
    }
    
    func showReadyCount(_ count: Int) {
        if count == 0 {
            readyLabel.text = nil
        } else {
            readyLabel.text = String(count)
        }
    }
    
    func setTimerCount(_ count: Int) {
        timerCountLabel.text = String(count)
    }
    
    func presentErrorView() {
        present(ErrorViewController(), animated: true, completion: nil)
    }
}

extension ExerciseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.exerciseList[presenter.exerciseIndex].exercise.explainList.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseExplainCell", for: indexPath) as? ExerciseExplainCell else {
            return UITableViewCell()
        }
        cell.setExplain(indexPath.row + 1, presenter.explainText(indexPath.row))
        return cell
    }
}
