//
//  PopupViewController.swift
//  Seniorigami
//
//  Created by Dimitri Yola on 13/04/21.
//

import UIKit

class PopupViewController: UIViewController {

    var selectedGallery: Gallery?
    

    @IBOutlet weak var popUpCV: UICollectionView!
    let popUpId = "PopupGalleryCVC"
    let popUpNextId = "PopupGalleryNextCVC"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibPopupCell = UINib(nibName: popUpId, bundle: nil)
        let nibPopupNext = UINib(nibName: popUpNextId, bundle: nil)
        
        popUpCV.register(nibPopupCell, forCellWithReuseIdentifier: popUpId)
        popUpCV.register(nibPopupNext, forCellWithReuseIdentifier: popUpNextId)
        
        
        /*
        origamiName.text = selectedGallery?.origami?.name
        origamiQuotes.text = selectedGallery?.origami?.quote
        userPhoto.image = UIImage(named: (selectedGallery?.image)!)
         */
 
        // Do any additional setup after loading the view.
    }
}

extension PopupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = popUpCV.dequeueReusableCell(withReuseIdentifier: popUpId, for: indexPath) as! PopupGalleryCVC
            cell.photoPopUp.image = UIImage(named: (selectedGallery?.image)!)
            cell.popUpOrigami.layer.cornerRadius = 50
            cell.popUpOrigami.layer.masksToBounds = true
            cell.quotesPopUpGallery.text = selectedGallery?.origami?.quote
            cell.popUpOrigami.text = selectedGallery?.origami?.name
            
            
            return cell
        } else {
            let cell = popUpCV.dequeueReusableCell(withReuseIdentifier: popUpNextId, for: indexPath) as! PopupGalleryNextCVC
            cell.achieveNext.image = UIImage(named: (selectedGallery?.image!)! + "-achievement")
            cell.quotesPopUp.text = selectedGallery?.origami?.quote
            let color = UIColor(named: (selectedGallery?.origami?.mode?.color)!)
            cell.nextView.layer.backgroundColor = color?.cgColor
            let gradient = CAGradientLayer()
            let endGradientColor = selectedGallery?.origami?.mode?.color
            
            gradient.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, UIColor(named: endGradientColor!)!.cgColor]
            gradient.frame = cell.nextView.bounds
                    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            
            
            cell.nextView.layer.cornerRadius = 10
            cell.nextView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nextView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            cell.nextView.layer.borderWidth = 1
                 
       
            cell.nextView.layer.insertSublayer(gradient, at: 0)
            cell.nextView.layer.masksToBounds = true
            
            
            
            
            cell.nameLabel.text = selectedGallery?.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM YYYY"
            cell.dateLabel.text = dateFormatter.string(from: (selectedGallery?.date)!)
            return cell
            
            
           
        }
    }
}
