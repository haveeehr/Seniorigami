//
//  StepViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class StepsViewController: UIViewController {
    
    var selected: String = ""

    @IBOutlet weak var stepsNavigationBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selected

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
