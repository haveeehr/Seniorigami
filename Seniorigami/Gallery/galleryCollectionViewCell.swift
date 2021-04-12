//
//  galleryCollectionViewCell.swift
//  Seniorigami
//
//  Created by Dimitri Yola on 12/04/21.
//

import UIKit

class galleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with gallery: Gallery2) {
        galleryImageView.image = gallery.image
        titleLabel.text = gallery.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
