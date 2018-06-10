//
//  noteTableViewCell.swift
//  HelloCoreData
//
//  Created by user on 2017/3/1.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var lab_date: UILabel!
    
    var clientName : String = ""
    var clientPhoneNumber : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
