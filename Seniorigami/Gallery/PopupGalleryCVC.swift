//
//  PopupGalleryCVC.swift
//  Seniorigami
//
//  Created by Dimitri Yola on 13/04/21.
//

import UIKit

class PopupGalleryCVC: UICollectionViewCell {
    @IBOutlet weak var popUpOrigami: UILabel!
    @IBOutlet weak var quotesPopUpGallery: UILabel!
    @IBOutlet weak var photoPopUp: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoPopUp.layer.cornerRadius = 10
        photoPopUp.layer.masksToBounds = true
        // Initialization code
    }

}


