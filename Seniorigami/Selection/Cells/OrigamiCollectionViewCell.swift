//
//  OrigamiCollectionViewCell.swift
//  Seniorigami
//
//  Created by Shiddiq Syuhada on 09/04/21.
//

import UIKit

class OrigamiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var paperLabel: UILabel!
    @IBOutlet weak var origamiImg: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        favoriteBtn.layer.borderWidth = 1
        favoriteBtn.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
//        favoriteBtn.setImage(UIImage(named: "plus"), for: .normal)
//        favoriteBtn.setImage(UIImage(named: "star.fill"), for: .highlighted)
    }
    
    @IBAction func isFavorited(_ sender: Any) {
        isFavorite.toggle()
        setButtonFavorite(view: sender as! UIButton, favStatus: isFavorite)
        
    }
    
    func setButtonFavorite(view: UIButton, favStatus: Bool){
        switch favStatus {
        case true:
            view.backgroundColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
            view.setTitle("Favorited", for: .normal)
            view.layer.borderWidth = 0
//            let image = UIImage(systemName: "star.fill")
            let smallConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .small)
            let smol = UIImage(systemName: "star.fill", withConfiguration: smallConfig)
            view.setImage(smol, for: .normal)
//            view.imageEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
            break
        case false:
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view.setImage(UIImage(systemName: "plus"), for: .normal)
            view.layer.borderWidth = 1
            view.setTitle("Favorite", for: .normal)
            
            break
//        default:
//            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
