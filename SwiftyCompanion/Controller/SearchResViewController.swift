//
//  SearchResViewController.swift
//  SwiftyCompanion
//
//  Created by Dmytro POGREBNIAK on 8/8/18.
//  Copyright © 2018 Dmytro POGREBNIAK. All rights reserved.
//

import UIKit

class SearchResViewController: UIViewController {

    var NickName = ""
    var NameSurname = ""
    var Number = 0
    var Points = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var NameSurnameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelNames()
        configTable()
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


}

extension SearchResViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        cell.ProjectName.text = "lol"
        
        //cell.backgroundColor = .black
        
        return cell
    }
}
