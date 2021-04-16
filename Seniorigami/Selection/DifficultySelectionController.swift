//
//  StepViewController.swift
//  Seniorigami
//
//  Created by Ghirlandaio on 13/04/21.
//

import UIKit

class DifficultySelectionController: UIViewController {
    
    @IBOutlet weak var difficultySelectionCollectionView: UICollectionView!
    
    @IBOutlet weak var difficultySelectionNavigation: UINavigationItem!
    
    var selected = Mode()
    
    var origamiCategorized = [Origami]()
    
    let difficultySelectionCollectionViewCellId = "OrigamiTestCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        difficultySelectionNavigation.title = selected.difficulty
        
        let nibCell = UINib(nibName: difficultySelectionCollectionViewCellId, bundle: nil)
        
        difficultySelectionCollectionView.register(nibCell, forCellWithReuseIdentifier: difficultySelectionCollectionViewCellId)
        
        difficultySelectionCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        difficultySelectionCollectionView.dataSource = self
        
        origamiCategorized = Database.shared.getOrigamiByMode(mode: selected)
    }
}
  
    

extension DifficultySelectionController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return origamiCategorized.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-40, height: collectionView.frame.height-40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = difficultySelectionCollectionView.dequeueReusableCell(withReuseIdentifier: difficultySelectionCollectionViewCellId, for: indexPath) as! OrigamiTestCollectionViewCell
            
        cell.setupCard(currentOrigami:origamiCategorized[indexPath.row])
        return cell
    }
    
    
  
    
    
}


