//
//  OrigamiSelect.swift
//  Seniorigami
//
//  Created by Shiddiq Syuhada on 09/04/21.
//

import Foundation

class OrigamiSelect {
    var id: String?
    var title: String?
    var step: String?
    var paper: String?
    var origamiimg: String?
    
    var data = [String]()

    required init?(){}
    
    func getOrigamiList(difficulty:String) -> [String] {
        switch difficulty {
        case "easy":
            data = getOrigamiList(difficulty: "easy")
        default:
            data = []
        }
        
        return data
    }
}
