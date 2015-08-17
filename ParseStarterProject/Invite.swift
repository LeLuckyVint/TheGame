//
//  Invite.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class Invite {
    var creator: User
    var inivteId: Int
    
    init(id: Int, creator: User){
        self.inivteId = id
        self.creator = creator
    }
}

extension UIAlertController{
    static func createAlertViewWithTitle(title: String?, message: String?) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        return alertController
    }
}