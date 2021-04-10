//
//  GenericCard.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 09/04/21.
//

import Foundation
import UIKit

class GenericCard: UIView {
    
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        
    }
}
