//
//  FavouriteViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var origamis = Database.shared.getFavouriteList()
    let favoriteCellId = "FavouriteCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editFavorite))
        
        let nibCell = UINib(nibName: favoriteCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: favoriteCellId)
    
        collectionView.reloadData()
        
    }
    
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

}

extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @objc func deleteFav(gestureRecognizer: UITapGestureRecognizer) {
        let loc = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView?.indexPathForItem(at: loc) {
            Database.shared.deleteFavourite(index: indexPath.row)
            collectionView.reloadData()
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView)-> Int{
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Database.shared.getFavouriteList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteCellId, for: indexPath) as! FavouriteCollectionViewCell
        
        
        if Database.shared.getFavouriteList().isEmpty == false{
            let origami = Database.shared.getFavouriteList()[indexPath.row].origami
            
            cell.difficultyLbl.text = "\(origami?.mode?.difficulty! ?? " ")"
            cell.difficultyLbl.sizeToFit()
            
            var color = UIColor()
            
            if origami?.mode?.difficulty == "Easy"{
                color = UIColor(named: "difficultyEasy")!
                cell.difficultyLbl.layer.backgroundColor = color.cgColor
            }else if origami?.mode?.difficulty == "Medium"{
                color = UIColor(named: "difficultyMedium")!
                cell.difficultyLbl.layer.backgroundColor = color.cgColor
            }else{
                color = UIColor(named: "difficultyHard")!
                cell.difficultyLbl.layer.backgroundColor = color.cgColor
            }
            
            cell.deleteBtn.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.deleteFav(gestureRecognizer:))))
            
            cell.origamiIV.image = UIImage(named: (origami?.image!)!)
            cell.origamiTitleLbl.text = origami?.name!
            
            cell.origamiStepsLbl.text = String((origami?.steps)!) + " steps"
            
            cell.origamiPaperLbl.text = origami?.paper!
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{

        let inset:CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 162, height: 216)
    }
}
