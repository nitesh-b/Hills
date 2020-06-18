//
//  MenuTableViewCell.swift
//  Hills
//
//  Created by nitesh.banskota on 4/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var icom: UIImageView!
 
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
