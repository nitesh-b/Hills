//
//  FooterTableViewCell.swift
//  Hills
//
//  Created by nitesh.banskota on 5/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func facebookPressed(_ sender: UIButton) {
        
    openURL("https://www.facebook.com/HillsLtd")
        
    }
    @IBAction func linkedinPressed(_ sender: UIButton) {
        openURL("https://www.linkedin.com/company/hills-holdings-ltd/")
    }
    @IBAction func youtubePressed(_ sender: UIButton) {
        openURL("https://www.youtube.com/channel/UCfDQtHUtyG0nIU3a_R0ooDw")
    }
    
    
    func openURL(_ url: String){
        UIApplication.shared.open(URL(string: url)! as URL, options: [:], completionHandler: nil)
    }
}
