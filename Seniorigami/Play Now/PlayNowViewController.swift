//
//  PlayNowViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class PlayNowViewController: UIViewController {

    //generate random origami for featured/recommendation
    var randomNumber = Int.random(in: 0...Database.shared.getOrigamiList().count - 1)
    let dataLog = Database.shared.getLog()
    let dataOrigami = Database.shared.getOrigamiList()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibMode = UINib(nibName: ModeCell.identifier , bundle: nil)
        tableView.register(nibMode, forCellReuseIdentifier: ModeCell.identifier)
        
        let nibRecent = UINib(nibName: RecentCell.identifier, bundle: nil)
        tableView.register(nibRecent, forCellReuseIdentifier: RecentCell.identifier)
        
        let nibHeader = UINib(nibName: HeaderCell.identifier, bundle: nil)
        tableView.register(nibHeader, forCellReuseIdentifier: HeaderCell.identifier)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let database = Database.shared.getModeList()
        let selectedRow = (tableView.indexPathForSelectedRow?.row)!
        
        if selectedRow == 0 {
            let destination = segue.destination as? StepsViewController
            if  dataLog.lastPlayed != nil {
                destination?.selected = dataLog.lastPlayed!
            } else {
                destination?.selected = dataOrigami[randomNumber]
            }
            
        } else {
            let destination = segue.destination as? DifficultySelectionController
                    destination?.selected = database[selectedRow - 2]
        }
    }
}

extension PlayNowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "segueFeatured", sender: self)
        } else if indexPath.row > 1 {
            performSegue(withIdentifier: "segueDifficultySelection", sender: self)
        }
    }
}

extension PlayNowViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        // 0 recent cell
        // 1 header cell (title & subtitle)
        // 3 - 4 mode cell
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier) as! RecentCell
            let dataFeatured = dataOrigami[randomNumber]
            
            if  dataLog.lastPlayed != nil {
                cell.topLeftLabel.text = "Recent"
                cell.topRightLabel.text = "\((dataLog.progress)!) of \((dataLog.lastPlayed?.steps)!)"
                cell.topRightLabel.backgroundColor = UIColor(named: "difficulty\((dataLog.lastPlayed?.mode?.difficulty)!)")
                cell.origamiTitle.text = dataLog.lastPlayed?.name
                cell.origamiThumbnail.image = UIImage(named: (dataLog.lastPlayed?.image)!)
                cell.totalSteps.text = "\((dataLog.lastPlayed?.steps)!) steps"
                
                return cell
            }
            
            cell.topRightLabel.text = dataFeatured.mode?.difficulty
            cell.topRightLabel.backgroundColor = UIColor(named: "difficulty\((dataFeatured.mode?.difficulty)!)")
            cell.topLeftLabel.text = "Try This!"
            cell.totalSteps.text = "\((dataFeatured.steps)!) steps"
            
            cell.origamiThumbnail.image = UIImage(named: dataFeatured.image!)
            cell.origamiTitle.text = dataFeatured.name
            return cell

        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ModeCell.identifier) as! ModeCell
        let data = Database.shared.getModeList()[indexPath.row - 2]
        
        cell.modeLabel.text = data.difficulty
        cell.stepsLabel.attributedText = imageLabel(data.stepDetail!, data.icon!)
        cell.thumbnailImage.image = UIImage(named: data.thumbnail!)
        cell.cardBackground.backgroundColor = UIColor(named: data.color!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier)
            
            //make sure that recent/featured card is always square
            return (cell?.bounds.width)!
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier)
            return (cell?.bounds.height)!
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ModeCell.identifier)
        return (cell?.bounds.height)!
    }
}

//function to add image/icon in front of UIlabel
func imageLabel(_ labelText: String, _ imageName: String, _ height: Int? = 16) -> NSAttributedString {
    
    let fullString = NSMutableAttributedString(string: "")

    if imageName != "" {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)
        imageAttachment.setImageHeight(height: CGFloat(height!))
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: " "))
        
    }
    
    fullString.append(NSAttributedString(string: labelText))
    
    return fullString
}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y - 2, width: ratio * height, height: height)
    }
}
