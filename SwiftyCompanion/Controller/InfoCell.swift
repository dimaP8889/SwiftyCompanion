//
//  InfoCell.swift
//  SwiftyCompanion
//
//  Created by Dmytro POGREBNIAK on 10.08.2018.
//  Copyright © 2018 Dmytro POGREBNIAK. All rights reserved.
//

import Foundation
import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet var NameSurname: UILabel!
    @IBOutlet var Level: UILabel!
    @IBOutlet var Face: UIImageView!
    @IBOutlet var CorrectionPoints: UILabel!
    @IBOutlet var PhoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func    setLabelNames(with Data: UserData){
        
//        if let name = Data.NameSurname {
//            if let mark = Data.Number {
//                if let success = Data.Points {
//                    NameSurname.text = name
//                }
//            }
//        }
        
        NameSurname.text = Data.NameSurname
        PhoneNumber.text = "Phone: " + Data.Number
        CorrectionPoints.text = "Points: " + Data.Points
        Level.text = "Level: " + Data.Level
        
        let url = URL(string: Data.Image)
        let data = NSData(contentsOf: url! as URL)
        Face.image = UIImage(data: data! as Data)
    }
}
