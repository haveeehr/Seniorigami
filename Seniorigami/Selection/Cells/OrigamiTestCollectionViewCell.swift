//
//  OrigamiTestCollectionViewCell.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 16/04/21.
//

import UIKit

class OrigamiTestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var paperLabel: UILabel!

    @IBOutlet weak var origamiImg: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var crownImage: UIImageView!
    
    var isFavorite = Bool()
    var origamiGlobalVariable = Origami()
    var origamis = [Origami]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
//        print(currentOrigami)
//        setupCard()
        favoriteButton.layer.borderWidth = 1
        favoriteButton.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        
       
    }
//    
//    func setupOrigami(origami: Origami) {
//        currentOrigami = origami
//    }
    
    func setupCard(currentOrigami: Origami){
        origamiGlobalVariable = currentOrigami
        let accentColor = UIColor(named: (currentOrigami.mode?.color)!)
       titleLabel.text = currentOrigami.name
      
    stepLabel.attributedText =  imageLabel("\(currentOrigami.steps!) Steps", "square.stack.3d.down.forward.fill")
       paperLabel.attributedText = imageLabel("\(currentOrigami.paper!)", "doc.fill")
        stepLabel.backgroundColor = accentColor
        paperLabel.backgroundColor = accentColor
        
       origamiImg.image = UIImage(named: currentOrigami.image!)
        
        if currentOrigami.finished == true {
            crownImage.isHidden = false
        }else{
            crownImage.isHidden = true
        }
        
        isFavorite = currentOrigami.favourite!
        setButtonFavorite(view: favoriteButton, favStatus: isFavorite)
    }
    
    @IBAction func isFavorited(_ sender: Any) {
        
        isFavorite.toggle()
        setButtonFavorite(view: sender as! UIButton, favStatus: isFavorite )
        Database.shared.appendFavourites(byOrigamiObject: origamiGlobalVariable, favourite: isFavorite )
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
          
            
            break
        case false:
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            view.setImage(UIImage(systemName: "plus"), for: .normal)
            view.layer.borderWidth = 1
            view.setTitle("Favorite", for: .normal)
         
            break

        }
    }

}
