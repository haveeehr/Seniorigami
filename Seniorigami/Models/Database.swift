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
                             Instruction(images: ["plane 9","plane 9-1"], desc: "Secure the fold by pressing."),
                             Instruction(images: ["plane 10"], desc: "Paper airplane is ready to fly!")])
        
        instructions.append([Instruction(images: ["crane 1","crane 1-0","crane 1-1","crane 1-2","crane 1-3"], desc: "Fold the left edge over to the right edge."),
                            Instruction(images: ["crane 2","crane 2-1","crane 2-2","crane 2-3","crane 2-4"], desc: "Unfold the paper and fold the top edge over to the bottom edge."),
                            Instruction(images: ["crane 3","crane 3-1","crane 3-2","crane 3-3","crane 3-4"], desc: "Rotate the paper and fold the left point to the right point."),
                            Instruction(images: ["crane 4","crane 4-1","crane 4-2","crane 4-3","crane 4-4"], desc: "Unfold the paper and fold the top point down to the bottom point."),
                            Instruction(images: ["crane 5","crane 5-1","crane 5-2","crane 5-3","crane 5-4"], desc: "Bring the left and right corners towards yourself and press it down."),
                            Instruction(images: ["crane 6","crane 6-1","crane 6-2","crane 6-3","crane 6-4"], desc: "Fold both of the edges of the front layer to the central crease and unfold it."),
                            Instruction(images: ["crane 7","crane 7-1","crane 7-2","crane 7-3","crane 7-4", "crane 7-5"], desc: "Fold the top point down to the central crease and unfold it."),
                            Instruction(images: ["crane 8","crane 8-1","crane 8-2","crane 8-3"], desc: "Open up the bottom point. Push the left and right edges towards the middle and flatten it."),
                            Instruction(images: ["crane 9"], desc: "Flip the paper over, from left to right."),
                            Instruction(images: ["crane 10","crane 10-1","crane 10-2","crane 10-3"], desc: "Fold bottom left and right diagonal edges to the middle."),
                            Instruction(images: ["crane 11"], desc: "Flip the paper over."),
                            Instruction(images: ["crane 12","crane 12-1"], desc: "Fold the bottom right point to the right and unfold it."),
                            Instruction(images: ["crane 13","crane 13-1"], desc: "Inside reverse fold from the previous step's crease."),
                            Instruction(images: ["crane 14"], desc: "Repeat the same step on the left side."),
                            Instruction(images: ["crane 15"], desc: "Choose one end to be the crane's head and fold it. Crane is finished!")])
        
        instructions.append([Instruction(images: ["bird 1 (1)", "bird 1 (2)", "bird 1 (3)", "bird 1 (4)", "bird 1 (5)"], desc: "Fold the left point over to the right point."),
                             Instruction(images: ["bird 2 (1)", "bird 2 (2)", "bird 2 (3)", "bird 2 (4)"], desc: "Fold the lower left and right diagonal edges to the middle."),
                             Instruction(images: ["bird 3"], desc: "Flip over the paper to the other side."),
                             Instruction(images: ["bird 4 (1)", "bird 4 (2)", "bird 4 (3)", "bird 4 (4)"], desc: "Fold the top point down."),
                             Instruction(images: ["bird 5"], desc: "Flip over the paper to the back side."),
                             Instruction(images: ["bird 6 (1)", "bird 6 (2)", "bird 6 (3)", "bird 6 (4)"], desc: "Fold the top left and right points diagonally inwards."),
                             Instruction(images: ["bird 7"], desc: "Unfold the previous step."),
                             Instruction(images: ["bird 8 (1)", "bird 8 (2)", "bird 8 (3)", "bird 8 (4)", "bird 8 (5)"], desc: "Open out the right side, reverse folding the front crease. Flatten the point down completely."),
                             Instruction(images: ["bird 9"], desc: "Repeat the previous step on the left side."),
                             Instruction(images: ["bird 10 (1)", "bird 10 (2)"], desc: "Fold the two flaps, they will become the bird's feet."),
                             Instruction(images: ["bird 11 (1)", "bird 11 (2)"], desc: "Fold the bottom side halfway upwards to make its tail."),
                             Instruction(images: ["bird 12 (1)", "bird 12 (2)", "bird 12 (3)", "bird 12 (4)"], desc: "Fold the left side over to the right."),
                             Instruction(images: ["bird 13 (1)", "bird 13 (2)"], desc: "Fold the top point over into the desired head shape."),
                             Instruction(images: ["bird 14 (1)", "bird 14 (2)"], desc: "Unfold the last step and fold it to the other side. Bird is complete!"),
        ])
        
        instructions.append([Instruction(images: ["None"], desc: "None")])
    }
    
    func seedOrigamiList(){
        seedMode()
        seedInstructions()
        
        origamis.append(Origami( name: "Plane", steps: 10, paper: "1 Origami Paper", mode: modes[0], quote: "Your wings already exist, all you have to do is fly.", image: "Plane", instructions: instructions[0], finished: false, favourite: false))
        
        origamis.append(Origami(name: "Crane", steps: 15, paper: "1 Origami Paper", mode: modes[0], quote: "What kind of bird works at a construction? A crane!", image: "Crane", instructions: instructions[1], finished: false, favourite: false))
        
        origamis.append(Origami(name: "Bird", steps: 14, paper: "1 Origami Paper", mode: modes[0], quote: "The bird who dares to fall is the bird who learns to fly", image: "Bird", instructions: instructions[2], finished: false, favourite: false))
        
        origamis.append(Origami( name: "Fox", steps: 28, paper: "2 Origami Paper" ,mode: modes[2], quote: "What does the fox say?", image: "Fox", instructions: instructions[3], finished: true, favourite: false))
        
        origamis.append(Origami( name: "Deer", steps: 20, paper: "1 Origami Paper", mode: modes[1],quote: "I'm quite fawn'd on you, my deer.", image: "Deer", instructions: instructions[3], finished: false, favourite: false))
        
        origamis.append(Origami( name: "Butterfly", steps: 35, paper: "3 Origami Paper", mode: modes[2], quote: "The wings of transformation are born of patience and struggle.", image: "Butterfly", instructions: instructions[3], finished: true, favourite: false))
        
        origamis.append(Origami( name: "Dog", steps: 23, paper: "1 Origami Paper", mode: modes[1], quote: "Dogs are not our whole life, but they make our lives whole.", image: "Dog", instructions: instructions[3], finished: false, favourite: false))
    
        origamis.append(Origami( name: "Cat", steps: 33, paper: "2 Origami Paper", mode: modes[2], quote: "Why couldn't the old cat see? He suffered from cataract.", image: "Cat", instructions: instructions[3], finished: false, favourite: false))
        
        origamis.append(Origami( name: "Squirrel", steps: 22, paper: "1 Origami Paper", mode: modes[1], quote: "What do you call a space travelling squirrel? An astronut.", image: "Squirrel", instructions: instructions[3], finished: false, favourite: false))
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
    
    func setOrigamiFinished(origami: Origami){
        for i in 0...origamis.count-1{
            if origamis[i].name == origami.name  {
                origamis[i].finished = true
                return
            }
        }
    }
    
    func setLog(origami: Origami, steps : Int){
        log.lastPlayed = origami
        log.progress = steps
    }
    
    func deleteFavourite(index: Int){
       favourites.remove(at: index)
    }
    
    func getOrigami(byName name: String) ->Origami{
        for i in 0 ... origamis.count - 1 {
            if origamis[i].name == name{
                return origamis[i]
            }
        }
        return origamis[0]
    }
    
    func addFavorites(name: String){
            for n in 0...origamis.count-1 {
                if origamis[n].name == name{
                    if origamis[n].favourite == false {
                        favourites.append(Favourite(origami: origamis[n]))
                        origamis[n].favourite = true
                    } else if origamis[n].favourite == true {
                        origamis[n].favourite = false
                        for m in 0...favourites.count-1 {
                            if favourites[m].origami?.name == name {
                                favourites.remove(at: m)
                                print("Delete Successful")
                                return
                            }
                        }
                    }
                    print("Added to favorites")
                    return
                }
            }
        }
}


