//
//  CongratulationsViewController.swift
//  Seniorigami
//
//  Created by Ghirlandaio on 14/04/21.
//

import UIKit

class CongratulationsViewController: UIViewController {

    var selectedOrigami : Origami? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedOrigami?.name
        
        // Do any additional setup after loading the view.
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
