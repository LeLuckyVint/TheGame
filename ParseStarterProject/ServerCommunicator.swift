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
    static func getProfile(){
        let token = defaults.stringForKey("token")!
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
    
    //ROOMS METHODS
    static func getRooms(completionHandler: (rooms: [Room]?, success: Bool)->Void){
        let token = defaults.stringForKey("token")!
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
                completionHandler(rooms: rooms, success: true)
            }
            else {
                completionHandler(rooms: nil, success: false)
            }
        }
    }
    
    //TODO
    static func createRoom(userId: Int, type: String, completionHandler: (success: Bool)->Void){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/rooms"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        let parameters = ["users":[userId], "type": type, "playersNumber": 2] as [String : AnyObject]
        var rooms: [Room]?
        Alamofire.request(.POST, url,parameters: parameters, encoding: .JSON, headers: headers).responseJSON { request, response, json, _ in
            if (response?.statusCode == 200){
                
            }
            else {
                
            }
        }
    }
    
    // FRIENDS METHODS
    static func getFriendsList(completionHandler: (friends: [User]?, success: Bool)->Void){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/friends"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var friends: [User]?
        Alamofire.request(.GET, url, encoding: .JSON, headers: headers).responseJSON { request, response, json, _ in
            if (response?.statusCode == 200){
                let jsonObject = JSON(json!)
                friends = self.jsonParser.getFriends(jsonObject)
                completionHandler(friends: friends, success: true)
            }
            else {
                completionHandler(friends: [], success: false)
            }
        }
    }
    
    static func getInvitesFriendsList(completionHandler: (invites: [Invite]?, success: Bool)->Void){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/friends/invites"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.GET, url, encoding: .JSON, headers: headers).responseJSON { request, response, json, _ in
            if (response?.statusCode == 200){
                let jsonObject = JSON(json!)
                invites = self.jsonParser.getInvitesList(jsonObject)
                completionHandler(invites: invites, success: true)
            }
            else {
                completionHandler(invites: nil, success: false)
            }
        }
    }
    
    static func sendInviteToUserWithId(id: Int){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/friends/invite/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.POST, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
    
    static func acceptInviteFromUserWithId(id: Int){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/friends/accept/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.POST, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
    
    static func declineInviteFromUserWithId(id: Int){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/friends/decline/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.POST, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
    
    static func deleteUserWithId(id: Int){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/friends/delete/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var invites: [Invite]?
        Alamofire.request(.DELETE, url, encoding: .JSON, headers: headers).response{ _, response, _, _ in
            println(response?.statusCode)
        }
    }
    
    //GAME METHODS
    static func commitMove(figures: Array2D<Figure>, gameId: Int){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/puzzle/commitMove/\(gameId)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var jsonToSend = Dictionary<String, AnyObject>()
        var dict = [Dictionary<String, AnyObject>]()
        for column in 0..<colNumber{
            for row in 0..<rowNumber{
                let figure = figures[column, row]
                if figure != nil{
                    let jsonFigure = ["type":figure!.getType().stringForServer, "color":figure!.getColor().stringForServer]
                    let json = ["figure": jsonFigure, "column":column, "row":row]
                    dict.append(json as! Dictionary<String, AnyObject>)
                }
            }
        }
        jsonToSend = ["moves":dict]
        
        Alamofire.request(.POST, url, parameters: jsonToSend, encoding: .JSON, headers: headers).response{ _, response, json, _ in
            if response?.statusCode == 200{
                
            }
        }
    }
    
    static func changeFiguresInHand(figures: [Figure], gameId: Int){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/puzzle/changeHand/\(gameId)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        var jsonToSend = Dictionary<String, AnyObject>()
        var dict = [Dictionary<String, AnyObject>]()
        for figure in figures{
            let jsonFigure = ["type":figure.getType().stringForServer, "color":figure.getColor().stringForServer]
            dict.append(jsonFigure)
        }
        jsonToSend = ["figures":dict]
        
        Alamofire.request(.POST, url, parameters: jsonToSend, encoding: .JSON, headers: headers).response{ _, response, json, _ in
            if response?.statusCode == 200{
                
            }
        }
    }
    
    static func searchUsers(text: String, completionHandler: (users: [User], success: Bool)->Void){
        let token = defaults.stringForKey("token")!
        let url = "https://www.play-like.me/API/rest/search/" + text
        let headers = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        Alamofire.request(.GET, url, encoding: .JSON, headers: headers).responseJSON{ _, response, json, _ in
            if response?.statusCode == 200{
                let users = JSONParser.sharedInstance.getUsersFromSearch(json as! NSArray)
                completionHandler(users: users, success: true)
            }
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