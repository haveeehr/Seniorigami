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
        let color = UIColor.init(named: (selected?.mode?.color)!)
        var imgs: [UIImage] = []
        for index in 0...(selected?.instructions![indexPath.row].images.count)!-1{
            imgs.append(UIImage(named: (selected?.instructions![indexPath.row].images[index]!)!)!)
        }
        cell.origamiStepImg.image = UIImage.animatedImage(with: imgs, duration: 3)
        cell.origamiStepCount.text = "\(indexPath.row+1) of \((selected?.steps)!)"
        cell.origamiStepCount.sizeToFit()
        cell.origamiStepDesc.text = selected?.instructions![indexPath.row].desc
        cell.origamiStepCount.layer.backgroundColor = color?.cgColor
        
        
        return cell
        
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
