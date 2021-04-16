//
//  OrigamiTestCollectionViewCell.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 16/04/21.
//

import UIKit

class OrigamiTestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var origamiStepImg: UIImageView!
    @IBOutlet weak var origamiStepCount:PaddingLabel!
    @IBOutlet weak var origamiStepDesc: UILabel!
    @IBOutlet weak var Microphone: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        origamiStepCount.sizeToFit()
        origamiStepCount.layer.cornerRadius = 10
    }

}
