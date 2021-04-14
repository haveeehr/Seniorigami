//
//  CongratulationsViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 07/04/21.
//

import UIKit

class CongratulationsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    var name: String = "Butterfly"
    var selectedOrigami = Origami()
    let date = Date()
    let dateFormatter = DateFormatter()
    var userImage: UIImage?
    var galleryList = Database.shared.getGalleryList()
    
    @IBOutlet weak var congratulationCardView: UIView!
    @IBOutlet weak var crownImage: UIImageView!
    @IBOutlet weak var selectedOrigamiQuotesLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var takeAPhotoButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        doneButton.isEnabled = false
        doneButton.tintColor = .clear
        
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height + 75
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
        
        doneButton.isEnabled = true
        doneButton.tintColor = UIView().tintColor
    }
    
    func setupView(){
        
        // Keyboard stuff
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(CongratulationsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(CongratulationsViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.dismissKeyboard()
        self.nameTextField.delegate = self
        
        
        // Pick Origami
        selectedOrigami = Database.shared.getOrigami(byName: name)
        let gradient = CAGradientLayer()
        let endGradientColor = selectedOrigami.mode?.color
        
        //Set Crown Image
        crownImage.image = #imageLiteral(resourceName: "crown")
        
        // Set Congratulation Card View
        congratulationCardView.layer.cornerRadius = 10
        congratulationCardView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        congratulationCardView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        congratulationCardView.layer.borderWidth = 1
        
        gradient.frame = congratulationCardView.bounds
        gradient.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, UIColor(named: endGradientColor!)!.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        congratulationCardView.layer.insertSublayer(gradient, at: 0)
        congratulationCardView.layer.masksToBounds = true
        
        
        selectedOrigamiQuotesLabel.text = selectedOrigami.quote
        
        takeAPhotoButton.layer.cornerRadius = 21
        
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        
        nameTextField.clipsToBounds = true
        nameTextField.overrideUserInterfaceStyle = .light
        
        mainImageView.image = UIImage(named: selectedOrigami.image! + "-achievement")
    }
    
    @IBAction func openCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        
        present(vc, animated: true)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        
        galleryList.append(Gallery(origami: selectedOrigami, image: userImage, date: date, name: nameTextField.text ))
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        userImage = image
        
        
    }
    
    
}
