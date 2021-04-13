//
//  Database.swift
//  Seniorigami
//
//  Created by Clara Anggraini on 08/04/21.
//

import Foundation

class Database{
    
    static let shared = Database()
    
    private var origamis = [Origami]()
    private var favourites = [Favourite]()
    private var log = Log()
    private var galleryList = [Gallery]()
    private var instructions = [[Instruction]]()
    private var modes = [Mode]()
    
    init(){
    }
    
    func seedMode(){
        modes.append(Mode(difficulty: "Easy", stepDetail: "15 steps", thumbnail: "thumbnail-fox", color: "cardEasy", icon: "chevron.left"))
        modes.append(Mode(difficulty: "Medium", stepDetail: "16-25 steps", thumbnail: "thumbnail-cat", color: "cardMedium", icon: ""))
        modes.append(Mode(difficulty: "Hard", stepDetail: "25 steps", thumbnail: "thumbnail-dog", color: "cardHard", icon: "chevron.right"))
    }
    
    func seedInstructions(){
        instructions.append([Instruction(images: ["plane 1"], desc: "Fold the paper in half."),
                             Instruction(images: ["plane 2"], desc: "Open up the folded paper."),
                             Instruction(images: ["plane 3","plane 3-1", "plane 3-2"], desc: "Fold the left and right of the top paper."),
                             Instruction(images: ["plane 4"], desc: "Fold to the edges to the center line."),
                             Instruction(images: ["plane 5","plane 5-1","plane 5-2"], desc: "Fold the plane in half."),
                             Instruction(images: ["plane 6","plane 6-1","plane 6-2"], desc: "Fold the half size of outer paper to the left to create the wing."),
                             Instruction(images: ["plane 7","plane 7-1"], desc: "Secure the fold by pressing."),
                             Instruction(images: ["plane 8","plane 8-1","plane 8-2"], desc: "Flip the paper to the back side, fold to create the wing."),
                             Instruction(images: ["plane 9","plane 9-1"], desc: "Secure the fold by pressing"),
                             Instruction(images: ["plane 10"], desc: "Paper airplane is ready to fly!")])
        instructions.append([Instruction(images: ["None"], desc: "None")])
    }
    
    func seedOrigamiList(){
        seedMode()
        seedInstructions()
        
        origamis.append(Origami( name: "Plane", steps: 10, paper: "1 Origami Paper", mode: modes[0], quote: "Your wings already exist, all you have to do is fly.", image: "Plane", instructions: instructions[0],finished: false))
        
        origamis.append(Origami( name: "Fox", steps: 15, paper: "1 Origami Paper" ,mode: modes[0], quote: "What does the fox say?", image: "Fox", instructions: instructions[1], finished: true))
   
        origamis.append(Origami( name: "Deer", steps: 20, paper: "1 Origami Paper", mode: modes[1],quote: "I'm quite fawn'd on you, my deer.", image: "Deer", instructions: instructions[1], finished: true))
        
        origamis.append(Origami( name: "Butterfly", steps: 35, paper: "3 Origami Paper", mode: modes[2], quote: "The wings of transformation are born of patience and struggle.", image: "Butterfly", instructions: instructions[1], finished: false))
        
        origamis.append(Origami( name: "Dog", steps: 23, paper: "1 Origami Paper", mode: modes[1], quote: "Dogs are not our whole life, but they make our lives whole.", image: "Dog", instructions: instructions[1], finished: false))
    
        origamis.append(Origami( name: "Cat", steps: 33, paper: "2 Origami Paper", mode: modes[2], quote: "Why couldn't the old cat see? He suffered from cataract.", image: "Cat", instructions: instructions[1], finished: false))
        
        origamis.append(Origami( name: "Squirrel", steps: 22, paper: "1 Origami Paper", mode: modes[1], quote: "What do you call a space travelling squirrel? An astronut.", image: "Squirrel", instructions: instructions[1], finished: true))
    }
    
    func deleteOrigami(index: Int){
        origamis.remove(at: index)
    }
    
    func getOrigamiList()->[Origami]{
        return origamis
    }
    
    func getGalleryList()->[Gallery]{
        return galleryList
    }
    
    func getLog()->Log{
        return log
    }
    
    func getFavouriteList()->[Favourite]{
        return favourites
    }
    
    func getModeList()->[Mode]{
        return modes
    }
    func getOrigamiByMode(mode: String) -> [Origami] {
        var origamiByMode = [Origami]()
        for i in 0...origamis.count-1 {
            if origamis[i].mode?.difficulty == mode {
                origamiByMode.append(origamis[i])
            }
        }
        return origamiByMode
    }
    
    
    func getGalleryByName(named: String) -> [Gallery] {
        var galleryByName = [Gallery]()
        for i in 0...galleryList.count-1 {
            if galleryList[i].origami?.name == named {
                galleryByName.append(galleryList[i])
            }
        }
        return galleryByName
    }
    
}
