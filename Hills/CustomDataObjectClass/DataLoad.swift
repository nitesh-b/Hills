//
//  DataLoad.swift
//  Hills
//
//  Created by nitesh.banskota on 25/5/20.
//  Copyright © 2020 Hills Limited. All rights reserved.
//

import Foundation

class DataLoad{
    var yes: Bool = false
    
    func setStatus(yes: Bool) {
        self.yes = yes
    
    }
    
    func getStatus() -> Bool{
        return self.yes
    }
}
