//
//  HeaderCell.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 08/04/21.
//

import UIKit

class HeaderCell: UITableViewCell {

    static let identifier = "HeaderCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.text = "Mode"
        subtitleLabel.text = "Choose the difficulty"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
