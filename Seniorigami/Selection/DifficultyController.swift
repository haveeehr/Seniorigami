//
//  DifficultyController.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 09/04/21.
//

import UIKit

class DifficultyController: UIViewController {

    var selected: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selected
    }

}

