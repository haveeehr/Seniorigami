//
//  FavouriteCollectionViewCell.swift
//  Seniorigami
//
//  Created by Clara Anggraini on 14/04/21.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var origamiView: GenericCard!
    @IBOutlet weak var difficultyLbl: UILabel!
    @IBOutlet weak var origamiIV: UIImageView!
    @IBOutlet weak var deleteBtn: UIImageView!
    @IBOutlet weak var origamiTitleLbl: UILabel!
    @IBOutlet weak var origamiStepsLbl: UILabel!
    @IBOutlet weak var origamiPaperLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        difficultyLbl.layer.cornerRadius = 10
        
        deleteBtn.isHidden = true
        
        deleteBtn.isUserInteractionEnabled = true
    }

}
