//
//  TableViewCell.swift
//  HelloCoreData
//
//  Created by User on 2017/2/22.
//  Copyright © 2017年 楊昇融. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var name: UILabel!
   
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var sex: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
