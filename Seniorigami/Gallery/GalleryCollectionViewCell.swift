//
//  CollectionCellView.swift
//  Seniorigami
//
//  Created by Dimitri Yola on 12/04/21.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        galleryImageView.layer.cornerRadius = 10
        galleryImageView.layer.masksToBounds = true
        // Initialization code
    }

}
