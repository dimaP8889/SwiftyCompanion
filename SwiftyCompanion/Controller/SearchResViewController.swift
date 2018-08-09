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
    var requestUrl = "https://api.intra.42.fr/v2/users/"
    
    var NickName = ""
    
    let Data = UserData()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NameSurnameLabel: UILabel!
    @IBOutlet weak var CorrectionPoints: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var Level: UILabel!
    @IBOutlet weak var Face: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        getToken()
    }
    
    func    setLabelNames() {
        
        NameSurnameLabel.text = Data.NameSurname
        PhoneNumber.text = "Phone: " + Data.Number
        CorrectionPoints.text = "Points: " + Data.Points
        Level.text = "Level: " + Data.Level
        
        let url = URL(string: Data.Image)
        let data = NSData(contentsOf: url! as URL)
        Face.image = UIImage(data: data! as Data)
        
    }
    
    func    getInfo(token : String) {
        let params: String = "Authorization Bearer \(token)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        print(params)
        Alamofire.request(requestUrl, headers : headers).responseJSON {
            response in
            if response.result.isSuccess {

                let results : JSON = JSON(response.result.value!)
                self.setParams(results: results)
                self.setLabelNames()
            } else {
                print ("Loshara Tupoi")
            }
        }
    }
    
    func    getToken() {
        let params:[String:String] = ["grant_type" : "client_credentials", "client_id" : UID, "client_secret" : SecretCode]
        Alamofire.request(tokenUrl, method : .post, parameters : params).responseJSON {
            response in
            if response.result.isSuccess {
                
                let tokenRes : JSON = JSON(response.result.value!)
                
                self.requestUrl += self.NickName
                self.getInfo(token: tokenRes["access_token"].stringValue)
            } else {
                print ("Loshara Tupoi")
            }
        }
    }
    
    func    setParams(results : JSON) {
        
        self.Data.NameSurname = results["displayname"].stringValue
        self.Data.Number = results["phone"].stringValue
        self.Data.Points = results["correction_point"].stringValue
        self.Data.Level = results["cursus_users"][0]["level"].stringValue
        self.Data.Image = results["image_url"].stringValue
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
