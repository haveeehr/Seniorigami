//
//  PopupViewController.swift
//  Seniorigami
//
//  Created by Dimitri Yola on 13/04/21.
//

import UIKit

class PopupViewController: UIViewController {

    var selectedGallery: Gallery?
    
    @IBOutlet weak var origamiQuotes: UILabel!
    @IBOutlet weak var origamiName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        origamiName.text = selectedGallery?.origami?.name
        origamiQuotes.text = selectedGallery?.origami?.quote
        userPhoto.image = UIImage(named: (selectedGallery?.image)!)
        // Do any additional setup after loading the view.
    }
    

   

}
