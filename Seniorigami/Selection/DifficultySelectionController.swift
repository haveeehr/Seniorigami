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
    
    var indexPathSelected = Int()
    
    var selected = Mode()

    var selecteditem = Origami()
    
    var origamiCategorized = [Origami]()
    
    let difficultySelectionCollectionViewCellId = "OrigamiTestCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        difficultySelectionCollectionView.delegate = self
        
        difficultySelectionNavigation.title = selected.difficulty
        
        let nibCell = UINib(nibName: difficultySelectionCollectionViewCellId, bundle: nil)
        
        difficultySelectionCollectionView.register(nibCell, forCellWithReuseIdentifier: difficultySelectionCollectionViewCellId)
        
        difficultySelectionCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        difficultySelectionCollectionView.dataSource = self
        
        origamiCategorized = Database.shared.getOrigamiByMode(mode: selected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
            let vc = segue.destination as? StepsViewController
            vc?.selected = selecteditem
    
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selecteditem = origamiCategorized[indexPath.row]
        print(selecteditem)
        performSegue(withIdentifier: "selectedOrigamiSegue", sender: self)
   
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset tartgetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.difficultySelectionCollectionView?.collectionViewLayout as!  UICollectionViewFlowLayout
        
        let cellWidthIncludingSpacing = (difficultySelectionCollectionView.frame.width-40) + layout.minimumLineSpacing
        
        var offset = tartgetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left ,y: 0)
        tartgetContentOffset.pointee = offset
    
        
    }
  
    
    
}


