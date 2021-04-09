//
//  CongratulationsViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 07/04/21.
//

import UIKit

class CongratulationsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var congratulationCardView: UIView!
    
    @IBOutlet weak var takeAPhotoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        // Do any additional setup after loading the view.
        
        
    }
    func setupView(){
        congratulationCardView.layer.cornerRadius = 10
        congratulationCardView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        congratulationCardView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        congratulationCardView.layer.borderWidth = 1

        let gradient = CAGradientLayer()
        
        gradient.frame = congratulationCardView.bounds
        gradient.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, UIColor(red: 0, green: 0.878, blue: 1, alpha: 0.35).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.9)
        congratulationCardView.layer.insertSublayer(gradient, at: 0)
        
        congratulationCardView.layer.masksToBounds = true
        
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
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
