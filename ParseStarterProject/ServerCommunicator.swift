//
//  ServerCommunicator.swift
//  The Game
//
//  Created by demo on 04.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class ServerCommunicator {
    class var sharedCommunicator: ServerCommunicator{
        return _sharedCommunicator
    }
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    static let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    static let jsonParser = JSONParser.sharedInstance
    
    static func createInvite(userId: Int, type: String, token: String){
        let url = "https://www.play-like.me/API/rest/room/"
        let parameters = ["users": [userId], "type": type, "playersNumber": 2] as [String : AnyObject]
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers)
            .response { request, response, json, _ in
                if (response?.statusCode == 200){
                    
                }
                println(response?.statusCode)
        }
    }
    
    static func login(username: String, password: String){
        let installationId = appDelegate.installation!.objectId!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let url = "https://www.play-like.me/API/rest/login/"
        let parameters = ["username": username, "password": password, "installationId": installationId]
        let headers = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers)
            .responseJSON { request, response, json, _ in
                if (response?.statusCode == 200){
                    let jsonObject = JSON(json!)
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-mm-dd HH:mm aaa ZZZ"
                    let expDate = jsonObject["expDate"].stringValue
                    let date = dateFormatter.dateFromString(expDate)
                    
                    let token = jsonObject["token"].stringValue
                    self.defaults.setObject(token, forKey: "token")
                    
                    self.appDelegate.window?.rootViewController = storyboard.instantiateInitialViewController() as? UIViewController
                }
                println(response?.statusCode)
        }
    }
    
    static func register(username: String, password: String, email: String){
        let installationId = appDelegate.installation!.objectId!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let url = "https://www.play-like.me/API/rest/register/"
        let parameters = ["username": username, "password": password, "email": email, "installationId": installationId]
        let headers = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers)
            .responseJSON { request, response, json, _ in
                if (response?.statusCode == 200){
                    let jsonObject = JSON(json!)
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-mm-dd HH:mm aaa ZZZ"
                    let expDate = jsonObject["expDate"].stringValue
                    let date = dateFormatter.dateFromString(expDate)
                    
                    let token = jsonObject["token"].stringValue
                    self.defaults.setObject(token, forKey: "token")
                    
                    self.appDelegate.window?.rootViewController = storyboard.instantiateInitialViewController() as? UIViewController
                }
                println(response?.statusCode)
        }
    }
    static func getProfile(token: String){
        let profileURL = "https://www.play-like.me/API/rest/profile"
        let profileHeaders = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        Alamofire.request(.GET, profileURL, headers: profileHeaders).responseJSON {
            request, response, json, _ in
            User.currentUser = self.jsonParser.getCurrentUser(JSON(json!))
        }
    }
    
    static func getRooms(token: String)-> [Room]?{
        let url = "https://www.play-like.me/API/rest/rooms"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var rooms: [Room]?
        Alamofire.request(.GET, url, encoding: .JSON, headers: headers).responseJSON { request, response, json, _ in
            if (response?.statusCode == 200){
                let jsonObject = JSON(json!)
                rooms = self.jsonParser.getRooms(jsonObject)
            }
            else {
                rooms = nil
            }
        }
        return rooms
    }

    static func getFriendsList(token: String) -> [User]?{
        let url = "https://www.play-like.me/API/rest/friend/friends"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var friends: [User]?
        Alamofire.request(.GET, url, encoding: .JSON, headers: headers).responseJSON { request, response, json, _ in
            if (response?.statusCode == 200){
                let jsonObject = JSON(json!)
                friends = self.jsonParser.getFriends(jsonObject)
            }
            else {
                friends = nil
            }
        }
        return friends
    }

    static func getInvitesFriendsList(token: String) -> [Invite]?{
        let url = "https://www.play-like.me/API/rest/friend/friends"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.GET, url, encoding: .JSON, headers: headers).responseJSON { request, response, json, _ in
            if (response?.statusCode == 200){
                let jsonObject = JSON(json!)
                invites = self.jsonParser.getInvitesList(jsonObject)
            }
            else {
                invites = nil
            }
        }
        return invites
    }
    
    static func sendInviteToUserWithId(id: Int, token: String){
        let url = "https://www.play-like.me/API/rest/friend/invite/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.POST, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
    
    static func acceptInviteFromUserWithId(id: Int, token: String){
        let url = "https://www.play-like.me/API/rest/friend/accept/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.POST, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
    
    static func declineInviteFromUserWithId(id: Int, token: String){
        let url = "https://www.play-like.me/API/rest/friend/decline/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.POST, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
    
    static func deleteUserWithId(id: Int, token: String){
        let url = "https://www.play-like.me/API/rest/friend/delete/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.DELETE, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
}
private var _sharedCommunicator = ServerCommunicator()

extension Reachability{
    static func showAlert(vc: UIViewController){
        let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(action)
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
}