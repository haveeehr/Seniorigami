//
//  GalleryViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class GalleryViewController: UIViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var origamis = [Origami]()
    
    let galleryCellId = "GalleryCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: galleryCellId, bundle: nil)
        
        
        galleryCollectionView.register(nibCell, forCellWithReuseIdentifier: galleryCellId)

        // Do any additional setup after loading the view.
       // origamis =
         //   Database.shared.getModeList(mode: "Easy")
        
       

      //  galleryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
 
    
    
  //  @IBOutlet var collectionView: UICollectionView!
 
    
    

   

  
    
    
    
    @IBAction func suitDidChanged(_ sender: UISegmentedControl) {
/*
            if sender.selectedSegmentIndex == 0{
                    origamis = Database.shared.getOrigamiByMode(mode: "Easy")
                }else if sender.selectedSegmentIndex == 1{
                    origamis = Database.shared.getOrigamiByMode(mode: "Medium")
                }else{
                    origamis = Database.shared.getOrigamiByMode(mode: "Hard")
                }
            collectionView.reloadData()
        }
    
*/






    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCollectionViewCell", for: indexPath) as! galleryCollectionViewCell
        cell.setup(with: galleries[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{

        let inset:CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}


extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 220)
    }
}










/*
 switch sender.selectedSegmentIndex {
 case 0:
     break
 case 1:
     break
 case 2:
     break
 default:
     break
 }
 */
 
