//
//  FavouriteViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var origamis = Database.shared.getOrigamiList()
    let favoriteCellId = "FavouriteCollectionViewCell"
    
    @objc func editFavorite(){
        
        if self.isEditing{
            for item in self.collectionView!.visibleCells as! [FavouriteCollectionViewCell] {
                let indexpath : NSIndexPath = self.collectionView!.indexPath(for: item as FavouriteCollectionViewCell)! as NSIndexPath
                let cell : FavouriteCollectionViewCell = self.collectionView!.cellForItem(at: indexpath as IndexPath) as! FavouriteCollectionViewCell
                cell.deleteBtn.isHidden = true
            }
            self.isEditing = false
            navigationItem.rightBarButtonItem = nil
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editFavorite))
        }else{
            for item in self.collectionView!.visibleCells as! [FavouriteCollectionViewCell] {
                let indexpath : NSIndexPath = self.collectionView!.indexPath(for: item as FavouriteCollectionViewCell)! as NSIndexPath
                let cell : FavouriteCollectionViewCell = self.collectionView!.cellForItem(at: indexpath as IndexPath) as! FavouriteCollectionViewCell
                cell.deleteBtn.isHidden = false
            
            }
            self.isEditing = true
            navigationItem.rightBarButtonItem = nil
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editFavorite))
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editFavorite))
        
        let nibCell = UINib(nibName: favoriteCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: favoriteCellId)
    
        collectionView.reloadData()
        
    }
    

}

extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @objc func deleteFav(gestureRecognizer: UITapGestureRecognizer) {
        let loc = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView?.indexPathForItem(at: loc) {
            Database.shared.deleteOrigami(index: indexPath.row)
            collectionView.reloadData()
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView)-> Int{
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Database.shared.getOrigamiList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteCellId, for: indexPath) as! FavouriteCollectionViewCell
        let origami = Database.shared.getOrigamiList()[indexPath.row]
        
        cell.difficultyLbl.text = "\(origami.mode?.difficulty! ?? " ")   "
        cell.difficultyLbl.sizeToFit()
        let color = UIColor(named: (origami.mode?.color)!)
        
        cell.difficultyLbl.layer.backgroundColor = color?.cgColor
        cell.deleteBtn.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.deleteFav(gestureRecognizer:))))
        
        cell.origamiIV.image = UIImage(named: origami.image!)
        cell.origamiTitleLbl.text = origami.name!
        
        cell.origamiStepsLbl.text = "\(origami.steps!) steps"
        
        cell.origamiPaperLbl.text = origami.paper!
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{

        let inset:CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = Database.shared.getOrigamiList()[indexPath.row]
    }

}
