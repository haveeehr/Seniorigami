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
        photoPopUp.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.984, alpha: 1)
        photoPopUp.layer.cornerRadius = 10
        photoPopUp.layer.masksToBounds = true
        // Initialization code
    }

}


