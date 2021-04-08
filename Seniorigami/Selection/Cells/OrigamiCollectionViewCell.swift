//
//  OrigamiCollectionViewCell.swift
//  Seniorigami
//
//  Created by Shiddiq Syuhada on 08/04/21.
//

import UIKit

class OrigamiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var paperLabel: UILabel!
    @IBOutlet weak var origamiImg: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
