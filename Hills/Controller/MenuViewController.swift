//
//  MenuViewController.swift
//  Hills
//
//  Created by nitesh.banskota on 4/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//
import SideMenu
import UIKit

class MenuViewController: UITableViewController {

    var items = ["", "Always Low price", "Special Offers","Latest Updates", "Article & Videos", "Finance", "Partner Program", "Legacy firmware download", "faqs","contact us", ""]
    var images = [UIImage(),
              UIImage(named: "alwaysLowPriceIcon"),
              UIImage(named: "specialOfferIcon"),
              UIImage(named: "latestUpdatesIcon"),
              UIImage(named: "videoIcon"),
              UIImage(named: "financeIcon"),
              UIImage(named: "partnerProgramIcon"),
              UIImage(named: "legecyFirmwareIcon"),
              UIImage(named: "faqsIcon"),
              UIImage(named: "contactUsIcon"),
              UIImage()]
        
        override func viewDidLoad() {
            tableView.backgroundColor = #colorLiteral(red: 0.141, green: 0.1529250145, blue: 0.1571277082, alpha: 1)
            tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "menuCell")
            tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerCell")
            tableView.register((UINib(nibName: "FooterTableViewCell", bundle: nil)), forCellReuseIdentifier: "footerCell")
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            items.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderTableViewCell
                cell.textLabel?.numberOfLines = 0
                return cell
            }else if indexPath.row == items.count - 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as! FooterTableViewCell
                return cell
            }
            else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
                cell.icom.image = images[indexPath.row]?.withTintColor(UIColor(named: "BrandColorBlue")!)
            cell.label.text = items[indexPath.row]
            return cell
            }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            switch indexPath.row {
            case 0:
                //Do Nothing
                tableView.cellForRow(at: indexPath)?.setHighlighted(true, animated: true)
            case 1:
                performSegue(withIdentifier: "alwaysLowPriceSegue", sender: self)
            case 2:
            performSegue(withIdentifier: "specialOfferSegue", sender: self)
            case 3:
                performSegue(withIdentifier: "latestUpdateSegue", sender: self)
            case 4...(items.count - 2):
                openURL(url: "https://www.google.com/")
            default:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        
        }
        
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
        return CGFloat(200)
        }else{
            return CGFloat(50)
        }
        
    }
    func openURL(url: String){
        UIApplication.shared.open(URL(string: url)! as URL, options: [:], completionHandler: nil)
     }
}
