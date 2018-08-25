//
//  Result_TableViewCell.swift
//  訂飲料
//
//  Created by Justin Lin on 2018/8/25.
//  Copyright © 2018年 ChienWen. All rights reserved.
//

import UIKit

class Result_TableViewCell: UITableViewCell {

    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_drink: UILabel!
    @IBOutlet weak var label_price: UILabel!
    @IBOutlet weak var label_sugar: UILabel!
    @IBOutlet weak var label_ice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
