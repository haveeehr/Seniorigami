//
//  StepViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class StepsViewController: UIViewController {
    
    @IBOutlet weak var stepsCollection: UICollectionView!
    @IBOutlet weak var finishButton: UIBarButtonItem!
    @IBOutlet weak var stepsNavigationBar: UINavigationItem!
    
    var selected : Origami? = nil
    let stepCellID = "StepCell"
    var dataLog = Database.shared.getLog()
    
    // var test = Database.shared.getOrigamiList()[0]
    
    
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
    
    //4.0 Mengirimkan state finished kepada congratulation view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        Database.shared.setOrigamiFinished(origami: selected!)
        
        selected?.finished = true
        
        let destination = segue.destination as? CongratulationsViewController
        
        destination?.selectedOrigami = selected
        
        
        /* test button
         var finishedState = Database.shared.getOrigamiList()[0]
         
         if finishedState.finished == true{
         print("true")
         }else{
         print("false")
         }
         
         print("test button")
         */
        
        
    }
    
}

extension StepsViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //notes 1.1: nambahin features ke class yang udah
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-40, height: collectionView.frame.height-40)
    }
    
    //notes 1.2: ngitung size collection view brp cell.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (selected?.instructions!.count)!
    }
    
    
    // notes 1.4: kaya naruh cell didalam collection view sesuai index (jadi jumlah si cell), as! itu nge recast
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = stepsCollection.dequeueReusableCell(withReuseIdentifier: stepCellID, for: indexPath) as! StepCell
        let color = UIColor.init(named: (selected?.mode?.color)!)
        //notes 1.5: nampung UIImage (cuman gara2 string di database, jadi harus di cast sebagai image disini)
        var imgs: [UIImage] = []
        //notes 1.6: ... itu maksudnya "sampai dengan"
        for index in 0...(selected?.instructions![indexPath.row].images.count)!-1{
            imgs.append(UIImage(named: (selected?.instructions![indexPath.row].images[index]!)!)!) //notes 1.7: dia masukin string name si image (dr DB) kedalam si UIimage jadi nanti image2 yang ada di asset tinggal dipanggil aja
        }
        cell.origamiStepImg.image = UIImage.animatedImage(with: imgs, duration: 3) //notes 1.8: automatis image sequencing pake array
        cell.origamiStepCount.text = "\(indexPath.row+1) of \((selected?.steps)!)" // notes 1.9: String interpolation
        cell.origamiStepCount.sizeToFit()
        cell.origamiStepDesc.text = selected?.instructions![indexPath.row].desc
        cell.origamiStepCount.layer.backgroundColor = color?.cgColor
        
        
        return cell
        
    }//notes 1.3: ngeload cellnya si collection view, cell diisi apa?
    
    //notes 2.0: ngatur centering
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset tartgetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.stepsCollection?.collectionViewLayout as!  UICollectionViewFlowLayout
        
        let cellWidthIncludingSpacing = (stepsCollection.frame.width-40) + layout.minimumLineSpacing
        
        var offset = tartgetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left ,y: 0)
        //print("roundedIndex: \(roundedIndex) -- ofset: \(offset)")
        tartgetContentOffset.pointee = offset
        
        //2.1 menyimpan progress dari step terakhir
        Database.shared.setLog(origami: selected!, steps: Int(roundedIndex))
        
        //2.2 mengatur availability dari Finish button
        if(Int(roundedIndex) == ((selected?.steps!)! - 1)){
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
}


// 3.0 Melakukan forcelock pada velocity sehingga slide dapat berjalan dengan lancar
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
