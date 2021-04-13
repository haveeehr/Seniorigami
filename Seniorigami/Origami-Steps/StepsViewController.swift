//
//  StepViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class StepsViewController: UIViewController {

    @IBOutlet weak var stepsCollection: UICollectionView!
    
    @IBOutlet weak var stepsNavigationBar: UINavigationItem!
    
    var origami = Database.shared.getOrigamiList()[0]
    
    let stepCellID = "StepCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibcell = UINib(nibName: stepCellID, bundle: nil)

        stepsCollection.register(nibcell, forCellWithReuseIdentifier: stepCellID)
    }
}

extension StepsViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    //notes 1.1: nambahin features ke class yang udah
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return origami.instructions.count
    }
    
    //notes 1.2: ngitung size collection view brp cell.
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // notes 1.4 kaya naruh cell didalam collection view sesuai index (jadi jumlah si cell), as! itu nge recast
        var cell = stepsCollection.dequeueReusableCell(withReuseIdentifier: stepCellID, for: indexPath) as! StepCell
        let color = UIColor.init(named: (origami.mode?.color)!)
        
        //nampung UIImage (cuman gara2 string di database, jadi harus di cast sebagai image disini)
        var imgs: [UIImage] = []
        //... itu maksudnya "sampai dengan"
        for index in 0...origami.instructions[indexPath.row].images.count-1{
            imgs.append(UIImage(named: origami.instructions[indexPath.row].images[index]!)!) //dia masukin string name si image (dr DB) kedalam si UIimage jadi nanti image2 yang ada di asset tinggal dipanggil aja
        }
        cell.origamiStepImg.image = UIImage.animatedImage(with: imgs, duration: 3) //automatis image sequencing pake array
    
        cell.origamiStepCount.text = "\(indexPath.row+1) of \(origami.steps!)" // String interpolation
        cell.origamiStepCount.sizeToFit()
        cell.origamiStepDesc.text = origami.instructions[indexPath.row].desc
        cell.origamiStepCount.layer.backgroundColor = color?.cgColor
        
        
        return cell
    }
    
    
    
    //notes 1.3: ngeload cellnya si collection view, cell diisi apa?
    
}
