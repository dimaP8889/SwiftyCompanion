//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Dmytro POGREBNIAK on 8/8/18.
//  Copyright © 2018 Dmytro POGREBNIAK. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class ViewController: UIViewController {

    let requestUrl = "https://api.intra.42.fr/v2/users/"
    let UID = "d7d492c61c7fdff3ba700084416e5a68511b5b898598da227c9ab541ddb20941"
    let SecretCode = "81617b0caa2f631e32492aa3015e05c4e57441f66dfba16ab621c6a5e2b7db57"
    let tokenUrl = "https://api.intra.42.fr/oauth/token"
    
    var requestParams = ""
    
    var NickName = ""
    
    let Data = UserData()
    
    @IBOutlet weak var SearchName: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Mark : Press Search button
    @IBAction func searchButtonTap(_ sender: UIButton) {
        
        SVProgressHUD.show()
        NickName = SearchName.text!.lowercased()
        getToken()
    }
    
    //Mark : Prapare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchResults" {
            
            let secondVC = segue.destination as! SearchResViewController
            
            secondVC.TableTiltle.title = self.NickName
            secondVC.Data = self.Data
        }
    }
    
    
    //Mark : Get Token for sending request
    func    getToken() {
        let params:[String:String] = ["grant_type" : "client_credentials", "client_id" : UID, "client_secret" : SecretCode]
        Alamofire.request(tokenUrl, method : .post, parameters : params).responseJSON {
            response in
            if response.result.isSuccess {
                
                let tokenRes : JSON = JSON(response.result.value!)
                
                self.requestParams = self.requestUrl + self.NickName
                self.getInfo(token: tokenRes["access_token"].stringValue)
            } else {
                SVProgressHUD.setMaximumDismissTimeInterval(1.5)
                SVProgressHUD.showError(withStatus: "Connection Error")
            }
        }
    }
    
    
    //Mark : Get Info about User
    func    getInfo(token : String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        Alamofire.request(requestParams, headers : headers).responseJSON {
            response in
            if response.result.isSuccess {
                
                let results : JSON = JSON(response.result.value!)
                self.setParams(results: results)
            } else {
                SVProgressHUD.setMaximumDismissTimeInterval(1.5)
                SVProgressHUD.showError(withStatus: "Connection Error")
            }
        }
    }
    
    //Mark : Set User parameters and perform a segue
    func    setParams(results : JSON) {
        
        if (results["displayname"] != JSON.null) {
            setUserParams(results: results)
            setProjectParams(results: results)
            setUserSkills(with : results)
            performSegue(withIdentifier: "SearchResults", sender: self)
            SVProgressHUD.dismiss()
        } else {
            SVProgressHUD.setMaximumDismissTimeInterval(1.5)
            SVProgressHUD.showError(withStatus: "No User Found")
        }
    }
    
    //Mark : Set users skills
    func    setUserSkills (with results : JSON) {
        
        let numberOfSkills : Int = results["cursus_users"][0]["skills"].count
        
        print(results)
        
        if numberOfSkills > 0 {
            
            Data.Skills.removeAll()
            for projCnt in 0...numberOfSkills - 1 {

                Data.Skills.append([results["cursus_users"][0]["skills"][projCnt]["name"].stringValue : results["cursus_users"][0]["skills"][projCnt]["level"].doubleValue])
            }
        } else {
            Data.Skills.removeAll()
        }
    }
    
    //Mark : Set User Params
    func    setUserParams(results : JSON) {
        
        self.Data.NameSurname = results["displayname"].stringValue
        self.Data.Number = results["phone"].stringValue
        self.Data.Points = results["correction_point"].stringValue
        self.Data.Level = "\(String(format: "%.2f", results["cursus_users"][0]["level"].doubleValue))"
        self.Data.Image = results["image_url"].stringValue
        self.Data.Email = results["email"].stringValue
        self.Data.Wallet = results["wallet"].stringValue
        self.Data.Place = results["location"].stringValue
        
        let url = URL(string: Data.Image)
        let data = NSData(contentsOf: url! as URL)
        self.Data.ImageDown = UIImage(data: data! as Data)
    }
    
    //Mark : Set Progects
    func    setProjectParams(results : JSON) {
        
        let numberOfProjects : Int = results["projects_users"].count
        
        if numberOfProjects > 0 {
            
            Data.Projects.removeAll()
            for projCnt in 0...numberOfProjects - 1 {
                
                if (results["projects_users"][projCnt]["project"]["slug"].stringValue.range(of: "piscine") == nil) {
                    Data.Projects.append([results["projects_users"][projCnt]["project"]["slug"].stringValue : results["projects_users"][projCnt]["final_mark"].intValue])
                }
            }
        } else {
            Data.Projects.removeAll()
        }
    }
}

