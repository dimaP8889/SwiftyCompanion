//
//  SearchResViewController.swift
//  SwiftyCompanion
//
//  Created by Dmytro POGREBNIAK on 8/8/18.
//  Copyright © 2018 Dmytro POGREBNIAK. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SearchResViewController: UITableViewController {
    
    @IBOutlet weak var TableTiltle: UINavigationItem!
    
    var Data = UserData()
    
    // Mark : Load
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    // Mark : Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // Mark : Number of Raws in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return Data.Skills.count
        }
        if section == 2 {
            return Data.Projects.count
        }
        return 0
    }
    
    // Mark : Set cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.allowsSelection = false
        if indexPath.section == 0 {

            if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell {
                cell.setLabelNames(with:Data)
                cell.backgroundColor = UIColor(patternImage: UIImage(named: "bg.png")!)
                return cell
            }
        }
        
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsCell", for: indexPath) as? SkillsCell {
                for (key,value) in Data.Skills[indexPath.row] {
                    
                    cell.SkillsName.text = "\(key) : \(String(format: "%.2f", value))"
                    cell.SkillProgress.setProgress(Float(value) / 20, animated: false)
                }
                return cell
            }
        }
        
        if indexPath.section == 2 {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            for (key,value) in Data.Projects[indexPath.row] {
                
                cell.ProjectName.text = "\(key)"
                cell.ProjectMark.text = "\(value)"
                cell.ProjectMark.textColor = UIColor.blue
                if (value < 75) {
                    
                    cell.LabelView.backgroundColor = UIColor.red
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // Mark : Height For a Row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        if indexPath.section == 1 {
            return 80
        }
        return 50
    }
    
    
    // Mark : Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    // Mark : Header for Section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return addHeader(text:"User Info")
        }
        if section == 1 {
            return addHeader(text:"User Skills")
        }
        if section == 2 {
            return addHeader(text:"User Projects")
        }
        return UIView()
    }
    
    // Mark : Make Header
    func addHeader(text: String) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.7, green:0.8, blue:0.8, alpha:1.0)
        
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 45, y: 5, width: 200, height: 35)
        view.addSubview(label)
        
        return view
    }
}
