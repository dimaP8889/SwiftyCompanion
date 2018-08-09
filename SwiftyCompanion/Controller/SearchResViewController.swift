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

class SearchResViewController: UIViewController {
    
    let UID = "d7d492c61c7fdff3ba700084416e5a68511b5b898598da227c9ab541ddb20941"
    let SecretCode = "81617b0caa2f631e32492aa3015e05c4e57441f66dfba16ab621c6a5e2b7db57"
    let tokenUrl = "https://api.intra.42.fr/oauth/token"
    
    var token = ""
    var NickName = ""
    
    let Data = UserData()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var NameSurnameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getToken()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    func    setLabelNames() {
        
        NameSurnameLabel.text = "lol"
    }
    
    func    configTable() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
    }
    
    func    getToken() {
        
        let params:[String:String] = ["grant_type" : "client_credentials", "client_id" : UID, "client_secret" : SecretCode]
        Alamofire.request(tokenUrl, method : .post, parameters : params).responseJSON {
            response in
            if response.result.isSuccess {
                
                let token : JSON = JSON(response.result.value!)
                self.token = token["access_token"].stringValue
            } else {
                print ("Loshara Tupoi")
            }
        }
    }


}

extension SearchResViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        cell.ProjectName.text = "lol"
        
        return cell
    }
}
