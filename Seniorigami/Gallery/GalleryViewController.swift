//
//  GalleryViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class GalleryViewController: UIViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var origamis = Database.shared.getOrigamiByMode(mode: "Easy")
    
    
    
    let galleryCellId = "GalleryCollectionViewCell" //untuk identifier
    let disabledCellId = "GalleryDisabledCell"
 
    @IBAction func suitDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            origamis = Database.shared.getOrigamiByMode(mode: "Easy")
        } else if sender.selectedSegmentIndex == 1 {
            origamis = Database.shared.getOrigamiByMode(mode: "Medium")
        } else {
            origamis = Database.shared.getOrigamiByMode(mode: "Hard")
        }
        galleryCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibGalleryCell = UINib(nibName: galleryCellId, bundle: nil) // mendaftarkan XIB
        let nibDisabledCell = UINib(nibName: disabledCellId, bundle: nil)
        
        
        galleryCollectionView.register(nibGalleryCell, forCellWithReuseIdentifier: galleryCellId)
        galleryCollectionView.register(nibDisabledCell, forCellWithReuseIdentifier: disabledCellId)

        
        // tambah viewdidgesture
    }
 
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if origamis[indexPath.row].finished == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCellId, for: indexPath) as! GalleryCollectionViewCell
            let origami = origamis[indexPath.row]
            cell.galleryImageView.image = UIImage (named: origami.image!)
            cell.titleLabel.text = origami.name!
          
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: disabledCellId, for: indexPath) as! GalleryDisabledCell
            let origami = origamis[indexPath.row]
            cell.disabledImageView.image = UIImage (named: origami.image!)
            cell.disabledLabel.text = origami.name!
            return cell
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return origamis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let origami = origamis[indexPath.row]
        if origami.finished == true {
            print("finished")
        } else {
            print("\(indexPath.row) - \(origami.name!)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{

        let inset:CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
