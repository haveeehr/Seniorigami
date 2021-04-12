//
//  RecentCell.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 08/04/21.
//

import UIKit

class RecentCell: UITableViewCell {

    static let identifier = "RecentCell"

    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    
    @IBOutlet weak var origamiTitle: UILabel!
    @IBOutlet weak var totalSteps: UILabel!
    
    @IBOutlet weak var origamiThumbnail: UIImageView!
    @IBOutlet weak var cardBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
