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
    @IBOutlet var Email: UILabel!
    @IBOutlet var Wallet: UILabel!
    @IBOutlet var Place: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func    setLabelNames(with Data: UserData){
        
        NameSurname?.text = Data.NameSurname
        PhoneNumber?.text = "Phone: " + Data.Number
        CorrectionPoints?.text = "Points: " + Data.Points
        Level?.text = "Level: " + Data.Level
        Email?.text = "Email: " + Data.Email
        Wallet?.text = "Wallet: " + Data.Wallet
        Place?.text = "Place: " + Data.Place
        
        let url = URL(string: Data.Image)
        let data = NSData(contentsOf: url! as URL)
        Face?.image = UIImage(data: data! as Data)
    }
}
