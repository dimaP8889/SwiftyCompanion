//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Dmytro POGREBNIAK on 8/8/18.
//  Copyright © 2018 Dmytro POGREBNIAK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var SearchName: UISearchBar!
    
    func readSearchName() {
        
        print(SearchName.text!)
    }
    
    @IBAction func searchButtonTap(_ sender: UIButton) {
        
        performSegue(withIdentifier: "SearchResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchResults" {
            
            let secondVC = segue.destination as! SearchResViewController
            
            secondVC.searchName = SearchName.text!
            
        }
    }
    
}

