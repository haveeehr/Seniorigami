//
//  StepViewController.swift
//  Seniorigami
//
//  Created by Ghirlandaio on 13/04/21.
//

import UIKit

class StepsViewController: UIViewController {
    
    @IBOutlet weak var stepsCollection: UICollectionView!
    
    @IBOutlet weak var finishButton: UIBarButtonItem!
    
    @IBOutlet weak var stepsNavigationBar: UINavigationItem!
    
    var selected : Origami? = nil
    
    let stepCellID = "StepCell"
    
    var dataLog = Database.shared.getLog()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selected?.name
    
        let nibcell = UINib(nibName: stepCellID, bundle: nil)
        
        stepsCollection.register(nibcell, forCellWithReuseIdentifier: stepCellID)
        
        stepsCollection.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        stepsCollection?.dataSource = self
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.tintColor = .clear
        
    
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (dataLog != nil && dataLog.lastPlayed?.name == selected?.name){
            let indexPath = IndexPath(item: dataLog.progress!, section: 0)
            self.stepsCollection.scrollToItem(at: indexPath, at: [.centeredVertically,.centeredHorizontally], animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Database.shared.setOrigamiFinished(origami: selected!)
        
        selected?.finished = true
        
        let destination = segue.destination as? CongratulationsViewController
        
        destination?.selectedOrigami = selected!
    }
    
}

extension StepsViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (selected?.instructions!.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-40, height: collectionView.frame.height-40)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = stepsCollection.dequeueReusableCell(withReuseIdentifier: stepCellID, for: indexPath) as! StepCell
       
        
        cell.setupCard(selected: selected!, indexPath: indexPath.row)
        return cell
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset tartgetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.stepsCollection?.collectionViewLayout as!  UICollectionViewFlowLayout
        
        let cellWidthIncludingSpacing = (stepsCollection.frame.width-40) + layout.minimumLineSpacing
        
        var offset = tartgetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left ,y: 0)
        tartgetContentOffset.pointee = offset
        
        Database.shared.setLog(origami: selected!, steps: Int(roundedIndex))
        
        
        if(Int(roundedIndex) == ((selected?.steps!)! - 1)){
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.tintColor = UIView().tintColor
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = .clear
        }
        
    }
    
    
}


class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        if let collectionViewBounds = self.collectionView?.bounds
        {
            let halfWidthOfVC = collectionViewBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds)
            {
                var candidateAttribute : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells
                {
                    let candAttr : UICollectionViewLayoutAttributes? = candidateAttribute
                    if candAttr != nil
                    {
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttr!.center.x - proposedContentOffsetCenterX
                        if abs(a) < abs(b)
                        {
                            candidateAttribute = attributes
                        }
                    }
                    else
                    {
                        candidateAttribute = attributes
                        continue
                    }
                }
                
                if candidateAttribute != nil
                {
                    return CGPoint(x: candidateAttribute!.center.x - halfWidthOfVC, y: proposedContentOffset.y);
                }
            }
        }
        return CGPoint.zero
    }
} 
