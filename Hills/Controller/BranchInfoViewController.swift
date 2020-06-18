//
//  BranchInfoViewController.swift
//  Hills
//
//  Created by nitesh.banskota on 3/6/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import UIKit

class BranchInfoViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timetableView: UIView!
    
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchAddress: UILabel!
    @IBOutlet weak var branchPhoneNumber: UILabel!
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    
    
    var branchInfo: BranchDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10;
        mainView.layer.masksToBounds = true
        timetableView.layer.cornerRadius = 10;
        timetableView.layer.masksToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        branchName.text = branchInfo?.name
        branchAddress.text = branchInfo?.address
        branchPhoneNumber.text = branchInfo?.phone
        monday.text = branchInfo?.openingHours["Monday"]
    }
    
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
