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

class SearchResViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    let UID = "d7d492c61c7fdff3ba700084416e5a68511b5b898598da227c9ab541ddb20941"
    let SecretCode = "81617b0caa2f631e32492aa3015e05c4e57441f66dfba16ab621c6a5e2b7db57"
    let tokenUrl = "https://api.intra.42.fr/oauth/token"
    var requestUrl = "https://api.intra.42.fr/v2/users/"
    
    var NickName = ""
    
    var Data = UserData()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.register(InfoCell.self, forCellReuseIdentifier: "InfoCell")
        self.tableView.register(SkillsCell.self, forCellReuseIdentifier: "SkillsCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 5
        }
        if section == 2 {
            return Data.Projects.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell {
                cell.setLabelNames(with:Data)
                return cell
            }
        }
        
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsCell", for: indexPath) as? SkillsCell {
                return cell
            }
        }
        
        if indexPath.section == 2 {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            
            for (key,value) in Data.Projects[indexPath.row] {
                
                cell.ProjectName.text = "\(key)"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
