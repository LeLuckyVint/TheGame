//
//  User.swift
//  The Game
//
//  Created by Vitaly on 02.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class User {
    let id: Int
    var username: String
    var email: String?
    var avatarURL: NSURL?
    var avatar: UIImage?{
        //return UIImage(data: NSData(contentsOfURL: avatarURL!)!)
        return UIImage(data: NSData(contentsOfURL: NSURL(string: "http://cs623318.vk.me/v623318367/1eab5/rCiTafl2x_s.jpg")!)!)
    }
    
    static var currentUser: User?
    
    init(id: Int, username: String, avatar: NSURL?, email: String){
        self.id = id
        self.username = username
        self.avatarURL = avatar
        self.email = email
    }
    init(id: Int, username: String, avatar: NSURL?){
        self.id = id
        self.username = username
        self.avatarURL = avatar
    }
}