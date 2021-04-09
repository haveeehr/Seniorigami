//
//  GenericCard.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 09/04/21.
//

import Foundation
import UIKit

class GenericCard: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}

