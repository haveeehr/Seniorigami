//
//  DifficultyController.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 09/04/21.
//

import UIKit

class DifficultyController: UIViewController {

    var selected: String = ""
    var randomOrigami =  Int.random(in: 0...2)
    
    override func viewDidAppear(_ animated: Bool) {
        print(Database.shared.getLog())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selected
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? StepsViewController
        destination?.selected = Database.shared.getOrigamiList()[randomOrigami]
        
    }
    
    
}

