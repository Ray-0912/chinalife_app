//
//  TableViewCell.swift
//  HelloCoreData
//
//  Created by 楊昇融 on 2017/2/11.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit

class VividCreatCell: UITableViewCell{
    
    
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var seperate: UILabel!
    
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var phone2: UILabel!
    @IBOutlet weak var seperate2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
