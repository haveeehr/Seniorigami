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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let database = Database.shared.getModeList()
        let selectedRow = (tableView.indexPathForSelectedRow?.row)!
        
        if let destination = segue.destination as? DifficultyController {
            if selectedRow == 0 {
                destination.selected = "Featured"
            } else {
                destination.selected = database[selectedRow - 1].difficulty ?? "Difficulty"
            }
        }
    }
    
}

extension PlayNowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segueDifficulty", sender: self)
        
    }
    
}

extension PlayNowViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier) as! RecentCell
            let data = Database.shared.getOrigamiList()[1]
            
            cell.topLeftLabel.text = "Recent"
            cell.topLeftLabel.backgroundColor = .white
            cell.topLeftLabel.layer.masksToBounds = true
            cell.topLeftLabel.layer.cornerRadius = 15.0
            cell.topLeftLabel.layer.borderWidth = 1.0
            cell.topLeftLabel.layer.borderColor = UIColor(named: "darkGray")?.cgColor
            
            cell.topRightLabel.text = "8 of 10"
            cell.topRightLabel.layer.masksToBounds = true
            cell.topRightLabel.layer.cornerRadius = 15.0
            
            cell.origamiThumbnail.image = UIImage(named: data.image!)
            
            cell.origamiTitle.text = data.name
            return cell

        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ModeCell.identifier) as! ModeCell
        let data = Database.shared.getModeList()[indexPath.row - 1]
        
        cell.modeLabel.text = data.difficulty
        cell.stepsLabel.attributedText = imageLabel(data.stepDetail!, data.icon!)
        cell.thumbnailImage.image = UIImage(named: data.thumbnail!)
        cell.cardBackground.backgroundColor = UIColor(named: data.color!)
        
        cell.stepsLabel.layer.masksToBounds = true
        cell.stepsLabel.layer.cornerRadius = 15.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier)
            
            //make sure that recent card is always square
            return (cell?.bounds.width)!
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
