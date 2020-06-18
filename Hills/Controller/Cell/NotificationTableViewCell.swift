//
//  NotificationTableViewCell.swift
//  Hills
//
//  Created by nitesh.banskota on 8/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationessageBody: UILabel!
    @IBOutlet weak var notiifcationTime: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var motificationIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
