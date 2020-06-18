//
//  TabBarViewController.swift
//  Hills
//
//  Created by nitesh.banskota on 4/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//
import SideMenu
import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var logoItem: UIBarButtonItem!
    
   // var menu: SideMenuNavigationController?
    var toggle: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
    SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    SideMenuManager.default.rightMenuNavigationController?.menuWidth = 400
    SideMenuManager.default.leftMenuNavigationController?.menuWidth = 400
    }
    
    @IBAction func burgerPressed(_ sender: UIBarButtonItem) {
      //  present(menu!, animated: true)
        toggle.toggle()
        if (toggle){
        print("Navigation Drawer On")
        } else{
            print("Navigation Off")
        }
    }
}
