//
//  BillTableViewCell.swift
//  EasyMoneyCoreData
//
//  Created by 郭勇 on 22/9/20.
//  Copyright © 2020 Yong Guo. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    // link to the view UI
    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var billAmount: UILabel!
    @IBOutlet weak var createAt: UILabel!
    @IBOutlet weak var billIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
