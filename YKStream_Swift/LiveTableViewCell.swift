//
//  LiveTableViewCell.swift
//  YKStream_Swift
//
//  Created by MinJing_Lin on 16/12/5.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var viewers: UILabel!
    @IBOutlet weak var bigImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
