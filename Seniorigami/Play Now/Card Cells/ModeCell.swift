//
//  ModeCell.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 08/04/21.
//

import UIKit

class ModeCell: UITableViewCell {
    
    static let identifier = "ModeCell"
    
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
