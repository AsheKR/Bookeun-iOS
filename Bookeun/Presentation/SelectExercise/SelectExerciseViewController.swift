//
//  SelectExerciseViewController.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import UIKit

class SelectExerciseViewController: ViewController<SelectExerciseViewControllerPresenter> {
    
    static let storyboardName = "SelectExercise"

    @IBOutlet private var tabButtons: [UIButton]!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var nextButton: UIButton!
    
    private var selectedIndex: Int = 0
    private var scrollIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.request()
        scrollToCenter()
    }

    override func attribute() {
        _ = tabButtons.enumerated().compactMap({
            let selected = $0.offset == selectedIndex

            $0.element.layer.cornerRadius = $0.element.bounds.height / 2
            $0.element.backgroundColor = selected ? #colorLiteral(red: 0, green: 1, blue: 0.6156862745, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.element.isSelected = selected
            
            $0.element.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .selected)
            $0.element.setTitleColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), for: .normal)
        })
        
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2.0
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setFlowLayout()
    }
    
    private func setFlowLayout() {
        let flowLayout = CenterCollectionLayout()
        let width: CGFloat = 217.0
        let margin: CGFloat = collectionView.bounds.width - width
        
        flowLayout.itemSize = CGSize(width: margin, height: collectionView.bounds.height)
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: margin / 2, bottom: 0.0, right: margin / 2)
        flowLayout.minimumLineSpacing = 16.0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal

        collectionView.collectionViewLayout = flowLayout
    }
    
    private func setSelect(_ index: Int, selected: Bool) {
        tabButtons[index].backgroundColor = selected ? #colorLiteral(red: 0, green: 1, blue: 0.6156862745, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabButtons[index].isSelected = selected
    }
    
    private func getCenterIndex(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.center.x + scrollView.contentOffset.x, y: .zero)

        if let selected = collectionView.indexPathForItem(at: center) {
            if scrollIndex != selected.row {
                scrollIndex = selected.row
            }
        }
    }

    private func scrollToCenter() {
        // TODO: 데이터 없을 때, 체크 필요
        
        print("\(scrollIndex)")
        let indexPath = IndexPath(row: scrollIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
        collectionView.invalidateIntrinsicContentSize()
    }
    
    @IBAction private func actionSelectTab(_ sender: UIButton) {
        let index = sender.tag

        setSelect(selectedIndex, selected: false)
        setSelect(index, selected: true)

        selectedIndex = index
        
        presenter.filterData(selectedIndex + 1)
    }
    
    @IBAction private func actionNextButton(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: ExerciseListViewController.storyboardName, bundle: nil)
                                    .instantiateViewController(withIdentifier: ExerciseListViewController.identifier) as? ExerciseListViewController else { return }
        viewController.presenter.selectedExerciseList = presenter.selectedExerciseList.map({ ExerciseWithCount(exercise: $0, count: 0) })
        present(viewController, animated: true, completion: nil)
    }
    
    func presentErrorView(error: Error) {
        present(ErrorViewController(), animated: true, completion: nil)
    }
    
    func update() {
        collectionView.reloadData()
    }
}

extension SelectExerciseViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        getCenterIndex(scrollView)
        scrollToCenter()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        getCenterIndex(scrollView)
        scrollToCenter()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let cell = collectionView.cellForItem(at: indexPath) as? SelectExerciseViewCell
        cell?.checkButton.isSelected.toggle()
        
        if indexPath.row < presenter.filteredExerciseList.count {
            let exercise = presenter.filteredExerciseList[indexPath.row]
            didTap(exercise)
        }
    }
}

extension SelectExerciseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.filteredExerciseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectExerciseViewCell.identifier,
                                                            for: indexPath) as? SelectExerciseViewCell else {
            return UICollectionViewCell()
        }
        let exercise = presenter.filteredExerciseList[indexPath.row]
        let selected = presenter.selectedExerciseList.first(where: { $0.id == exercise.id })
        
        cell.delegate = self
        cell.setExercise(exercise, checked: selected != nil)
        
        return cell
    }
}

extension SelectExerciseViewController: SelectExerciseViewCellDelegate {
    
    func didTap(_ exercise: Exercise?) {
        guard let exercise = exercise else { return }
        presenter.updateSelectedExerciseList(exercise)
    }
}
