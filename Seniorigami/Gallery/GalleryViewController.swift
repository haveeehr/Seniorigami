//
//  GalleryViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class GalleryViewController: UIViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var origamis = Database.shared.getOrigamiList()
    
    
    
    let galleryCellId = "GalleryCollectionViewCell" //untuk identifier
    let disabledCellId = "GalleryDisabledCell"
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibGalleryCell = UINib(nibName: galleryCellId, bundle: nil) // mendaftarkan XIB
        let nibDisabledCell = UINib(nibName: disabledCellId, bundle: nil)
        

        //galleryCollectionView.register(nibGalleryCell, forCellWithReuseIdentifier: galleryCellId)
        
        galleryCollectionView.register(nibGalleryCell, forCellWithReuseIdentifier: galleryCellId)
        
        //galleryCollectionView.register(nibDisabledCell, forCellWithReuseIdentifier: disabledCellId)

        // Do any additional setup after loading the view.
       // origamis =
         //   Database.shared.getModeList(mode: "Easy")
        
       

      //  galleryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
  //  @IBOutlet var collectionView: UICollectionView!
 
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCellId, for: indexPath) as! GalleryCollectionViewCell
        let origami = origamis[indexPath.row]
        cell.galleryImageView.image = UIImage (named: origami.image!)
        cell.titleLabel.text = origami.name!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return origamis.count
    }
    
  
        
        
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{

        let inset:CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
