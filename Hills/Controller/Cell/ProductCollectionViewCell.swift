//
//  ProductCollectionViewCell.swift
//  Hills
//
//  Created by nitesh.banskota on 11/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productManufacturer: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSku: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        layer.cornerRadius = 2
        // Initialization code
    }

}
