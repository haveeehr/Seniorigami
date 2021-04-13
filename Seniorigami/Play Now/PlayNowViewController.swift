//
//  PlayNowViewController.swift
//  Seniorigami
//
//  Created by Javier Fransiscus on 06/04/21.
//

import UIKit

class PlayNowViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
        
        if let destination = segue.destination as? DifficultyController {
            if selectedRow == 0 {
                destination.selected = "Featured"
            } else {
                destination.selected = database[selectedRow - 2].difficulty ?? "Difficulty"
            }
        }
    }
    
}

extension PlayNowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 1 {
            performSegue(withIdentifier: "segueDifficulty", sender: self)
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
            let data = Database.shared.getOrigamiList()[1]
            
            cell.topRightLabel.text = "8 of 10"
            cell.topLeftLabel.text = "Recent"
            
            cell.origamiThumbnail.image = UIImage(named: data.image!)
            cell.origamiTitle.text = data.name
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
func imageLabel(_ labelText: String, _ imageName: String) -> NSAttributedString {
    
    let fullString = NSMutableAttributedString(string: "")

    if imageName != "" {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: " "))
        
    }
    
    fullString.append(NSAttributedString(string: labelText))
    
    return fullString
}
