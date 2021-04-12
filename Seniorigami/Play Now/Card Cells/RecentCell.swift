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
    @IBOutlet weak var gradientBackground: UIView!
    
    @IBOutlet weak var origamiThumbnail: UIImageView!
    @IBOutlet weak var cardBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        topLeftLabel.backgroundColor = .white
        topLeftLabel.layer.masksToBounds = true
        topLeftLabel.layer.cornerRadius = 15.0
        topLeftLabel.layer.borderWidth = 1.0
        topLeftLabel.layer.borderColor = UIColor(named: "darkGray")?.cgColor
        
        topRightLabel.layer.masksToBounds = true
        topRightLabel.layer.cornerRadius = 15.0
        
        //Gradient layer on the bottom for text readability
        gradientBackground.backgroundColor = UIColor.clear
        gradientBackground.layer.cornerRadius = 10.0
        gradientBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        gradientBackground.layer.masksToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientBackground.bounds
        gradientLayer.colors = [UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0).cgColor, UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor]
        gradientBackground.layer.insertSublayer(gradientLayer, at: 0)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.15
        lpgr.delaysTouchesBegan = false
        self.addGestureRecognizer(lpgr)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
