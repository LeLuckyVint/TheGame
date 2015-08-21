//
//  PlayersDataSourceDelegate.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class PlayersDataSourceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var friends: [User] = []
    let profileIdentifier = "playerCell"
    
    let token = NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
    
    var controller: PlayersTableViewController!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == friends.count{
            var cell = tableView.dequeueReusableCellWithIdentifier("newFriendCell", forIndexPath: indexPath) as! UITableViewCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier(profileIdentifier, forIndexPath: indexPath) as! PlayerTableViewCell
            // Configure the cell
            let friend = friends[indexPath.row]
            
            cell.usernameLabel.text = friend.username
            cell.avatarImageView.image = friend.avatar
            cell.emailLabel.text = friend.email
            cell.friendId = friend.id
            
            return cell
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == friends.count{
            controller.performSegueWithIdentifier("sendInvite", sender: self)
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier(profileIdentifier, forIndexPath: indexPath) as! PlayerTableViewCell
            let userId = friends[indexPath.row].id
            let type = controller.typeOfGame.getStringForJSON()
            ServerCommunicator.createRoom(userId, type: type){
                success in
                let ac = UIAlertController.createAlertViewWithTitle("Success!", message: "Wait til your friend accept the game")
                var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("roomsViewController") as! RoomsTableViewController
                self.controller.presentViewController(vc, animated: true, completion: nil)
                vc.presentViewController(ac, animated: true, completion: nil)
                
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func updateFriendsList(){
        ServerCommunicator.getFriendsList{
            array, success in
            if success{
                self.friends = array
            }
            else{
                println("pizda")
            }
            self.controller.tableView.reloadData()
        }
    }
    
    override init(){
        super.init()
        updateFriendsList()
        
    }
}