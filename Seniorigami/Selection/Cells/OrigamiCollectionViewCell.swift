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
    @IBOutlet weak var crownImage: UIImageView!
    
    var isFavorite: Bool = false
//    var favoriteOrigami = Database.shared
    var origamis = [Origami]()
    var dataorigami = Database.shared.getOrigamiList()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        favoriteBtn.layer.borderWidth = 1
        favoriteBtn.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
//        favoriteBtn.setImage(UIImage(named: "plus"), for: .normal)
//        favoriteBtn.setImage(UIImage(named: "star.fill"), for: .highlighted)
        crownImage.isHidden = true
       
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
            let smallConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .small)
            let smol = UIImage(systemName: "star.fill", withConfiguration: smallConfig)
            view.setImage(smol, for: .normal)
            
            Database.shared.addFavorites(name: titleLabel.text!)
            
            break
        case false:
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            view.setImage(UIImage(systemName: "plus"), for: .normal)
            view.layer.borderWidth = 1
            view.setTitle("Favorite", for: .normal)
            Database.shared.addFavorites(name: titleLabel.text!)
            break
//        default:
//            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
