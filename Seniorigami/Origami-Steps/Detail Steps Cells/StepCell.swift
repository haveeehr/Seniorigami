//
//  StepCell.swift
//  Seniorigami
//
//  Created by Ghirlandaio on 13/04/21.
//

import UIKit

class StepCell: UICollectionViewCell {

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
