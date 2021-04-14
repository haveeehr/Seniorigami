//
//  DifficultyController.swift
//  Seniorigami
//
//  Created by Yahya Ayyash on 09/04/21.
//

import UIKit

class DifficultyController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var selected: Mode? = nil
    var origamiList = [Origami]()
    let origamiCollectionViewCellId = "OrigamiCollectionViewCell"
    
    var selectedDifficulty = Mode()
    
    var dataOrigami = Database.shared.getOrigamiList()
    var favoriteOrigami = Database.shared.getFavouriteList()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selected?.difficulty
        collectionView.delegate = self
        
        let nibCell = UINib(nibName: origamiCollectionViewCellId, bundle: nil)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.register(nibCell, forCellWithReuseIdentifier: origamiCollectionViewCellId)
        print(dataOrigami.count)
        for i in 0...dataOrigami.count - 1 {
            if dataOrigami[i].mode?.difficulty == selected?.difficulty{
                origamiList.append(dataOrigami[i])
//                print(dataOrigami[i].mode, selected?.difficulty)
            }
        }
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination  = segue.destination as? StepsViewController
        let selecteditem = collectionView.indexPathsForSelectedItems?[0].row
//        let origamiSelected = Origami()
        
        destination?.selected = origamiList[selecteditem!]
        print(origamiList[selecteditem!].name!)
        print(favoriteOrigami)
    }
    
    
}

extension DifficultyController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return origamiList.count
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let inset:CGFloat = 10
            return UIEdgeInsets(top: inset, left: inset, bottom:inset, right:inset)
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: origamiCollectionViewCellId, for: indexPath) as! OrigamiCollectionViewCell
            
            let origami = origamiList[indexPath.row]
            
            cell.titleLabel.text = origami.name!
            cell.origamiImg.image = UIImage(named: origami.image!)
            cell.stepLabel.attributedText =  imageLabel("\(origami.steps!) Steps", "square.stack.3d.down.forward.fill")
            cell.paperLabel.attributedText = imageLabel("\(origami.paper!)", "doc.fill")
            cell.stepLabel.backgroundColor = UIColor(named: "card\((selected?.difficulty)!)")
            cell.paperLabel.backgroundColor = UIColor(named: "card\((selected?.difficulty)!)")
            
            if origami.finished! {
                cell.crownImage.isHidden = false
            }
            
            
            cell.setButtonFavorite(view: cell.favoriteBtn, favStatus: origami.favourite!)
            
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let origami = origamis[indexPath.row]
//            print("\(indexPath.row) - \(origami.title!)")
            let selecteditem = dataOrigami[indexPath.row]
//            print(selecteditem.name)
            performSegue(withIdentifier: "selectedOrigamiSegue", sender: self)
        }
}
