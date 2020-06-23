//
//  EventCollectionViewCell.swift
//  Hills
//
//  Created by nitesh.banskota on 1/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imgName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var textBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    @IBAction func eventButton(_ sender: UIButton) {
        }
}
