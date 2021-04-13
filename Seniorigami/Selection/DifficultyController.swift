//
//  DifficultyController.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 09/04/21.
//

import UIKit

class DifficultyController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var selected: String = ""
    var origamis = [OrigamiSelect]()
    let origamiCollectionViewCellId = "OrigamiCollectionViewCell"
    
    var dataOrigami = Database.shared.getOrigamiList()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selected
        
        collectionView.delegate = self
        
        let nibCell = UINib(nibName: origamiCollectionViewCellId, bundle: nil)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        collectionView.register(nibCell, forCellWithReuseIdentifier: origamiCollectionViewCellId)
                
//        let dataTitle = ["Plane","Fox","Cat","Dog","Boat"]
//        let dataStep = ["10 Steps","5 Steps","15 Steps","20 Steps","25 Steps",]
//        let dataPaper = ["1 Origami","2 Origami","3 Origami","4 Origami","5 Origami",]
//
        for _ in 1...5 {
            let origami = OrigamiSelect()
            origami?.title = "Plane"
            origami?.step = "10 Steps"
            origami?.paper = "1 Origami"

            origamis.append(origami!)
        }

        
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination  = segue.destination as? StepsViewController
        let selecteditem = collectionView.indexPathsForSelectedItems?[0].row
        destination?.selected = dataOrigami[selecteditem!].name!
        print(dataOrigami[selecteditem!].name!)
    }

}

extension DifficultyController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return origamis.count
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let inset:CGFloat = 10
            return UIEdgeInsets(top: inset, left: inset, bottom:inset, right:inset)
        }

//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: UIScreen.main.bounds.width, height: 591)
//        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: origamiCollectionViewCellId, for: indexPath) as! OrigamiCollectionViewCell
//            let origami = origamis[indexPath.row]
//            cell.origamiImg.image = UIImage(named: "Plane")
//            cell.titleLabel.text = origami.title!
//            cell.stepLabel.text = origami.step!
//            cell.paperLabel.text = origami.paper!
            
            let origami = Database.shared.getOrigamiList()[indexPath.row]
            
            cell.titleLabel.text = origami.name!
//            cell.paperLabel.text = origami.paper!
//            cell.stepLabel.text = "\(origami.steps!) Steps"
            cell.origamiImg.image = UIImage(named: origami.image!)
            cell.stepLabel.attributedText =  imageLabel("\(origami.steps!) Steps", "square.stack.3d.down.forward.fill")
            cell.paperLabel.attributedText = imageLabel("\(origami.paper!)", "doc.fill")
            cell.stepLabel.backgroundColor = UIColor(named: "card\(selected)")
            cell.paperLabel.backgroundColor = UIColor(named: "card\(selected)")
            
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let origami = origamis[indexPath.row]
//            print("\(indexPath.row) - \(origami.title!)")
            let selecteditem = dataOrigami[indexPath.row]
            print(selecteditem.name)
            performSegue(withIdentifier: "selectedOrigamiSegue", sender: self)
        }
}
