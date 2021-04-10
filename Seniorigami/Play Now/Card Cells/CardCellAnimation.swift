//
//  CardCellAnimation.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 10/04/21.
//

import Foundation
import UIKit

extension ModeCell {
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        if gesture.state.rawValue == 1 {
            highlight(true)
        } else {
            highlight(false)
        }
    }

    func highlight(_ touched: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: [.allowUserInteraction], animations: {self.transform = touched ? .init(scaleX: 0.95, y: 0.95) : .identity }, completion: nil)
    }
}

extension RecentCell {
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        if gesture.state.rawValue == 1 {
            highlight(true)
        } else {
            highlight(false)
        }
    }

    func highlight(_ touched: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: [.allowUserInteraction], animations: {self.transform = touched ? .init(scaleX: 0.95, y: 0.95) : .identity }, completion: nil)
    }
}
