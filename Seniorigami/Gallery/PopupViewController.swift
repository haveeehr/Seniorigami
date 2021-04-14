//
//  PopupViewController.swift
//  Seniorigami
//
//  Created by Dimitri Yola on 13/04/21.
//

import UIKit

class PopupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedGallery: Gallery?
    var galleryViewController: GalleryViewController?
    
    @IBOutlet weak var popUpCV: UICollectionView!
    let popUpId = "PopupGalleryCVC"
    let popUpNextId = "PopupGalleryNextCVC"
    
    
    @IBOutlet weak var pageIndicator: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pageIndicator.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)

        

        
        let nibPopupCell = UINib(nibName: popUpId, bundle: nil)
        let nibPopupNext = UINib(nibName: popUpNextId, bundle: nil)
        
        popUpCV.register(nibPopupCell, forCellWithReuseIdentifier: popUpId)
        popUpCV.register(nibPopupNext, forCellWithReuseIdentifier: popUpNextId)
        
        self.modalPresentationStyle = .fullScreen
        
        self.view.isUserInteractionEnabled = true

        dismissPopup()
        

        /*
         origamiName.text = selectedGallery?.origami?.name
         origamiQuotes.text = selectedGallery?.origami?.quote
         userPhoto.image = UIImage(named: (selectedGallery?.image)!)
         */
        
        // Do any additional setup after loading the view.
    }
    
    func dismissPopup() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(dismissPopupTouchOutside))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    
    @objc private func dismissPopupTouchOutside() {
        galleryViewController?.galleryCollectionView.reloadData()
        self.dismiss(animated: true)
    }
}




extension PopupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageIndicator.numberOfPages = 2
        return 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageIndicator.currentPage = Int(pageNumber)
    }
    
    
    @objc func openCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let photoPopup = info[.editedImage] as? UIImage else {
            print("No image found")
            return
            
        }
        Database.shared.setGalleryImage(gallery: selectedGallery!, image: photoPopup)
        let before = selectedGallery?.origami
        
        selectedGallery = Database.shared.getGallery(origami: before!)
        popUpCV.reloadData()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            
            let cell = popUpCV.dequeueReusableCell(withReuseIdentifier: popUpId, for: indexPath) as! PopupGalleryCVC
            cell.photoPopUp.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.openCamera(_:))))
            
            
            if selectedGallery?.image != nil {
                cell.photoPopUp.image = selectedGallery?.image
                
            } else {
                cell.photoPopUp.image = UIImage(named: "imagePlaceholder")
                cell.photoPopUp.isUserInteractionEnabled = true
            }
            
            
            cell.popUpOrigami.layer.cornerRadius = 50
            cell.popUpOrigami.layer.masksToBounds = true
            cell.quotesPopUpGallery.text = selectedGallery?.origami?.quote
            cell.popUpOrigami.text = selectedGallery?.origami?.name
            
            
            return cell
        } else {
            let cell = popUpCV.dequeueReusableCell(withReuseIdentifier: popUpNextId, for: indexPath) as! PopupGalleryNextCVC
            cell.achieveNext.image = UIImage(named: (selectedGallery?.origami?.name!)! + "-achievement")
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
