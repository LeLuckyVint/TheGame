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
            
            return cell
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == friends.count{
            controller.performSegueWithIdentifier("sendInvite", sender: nil)
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier(profileIdentifier, forIndexPath: indexPath) as! PlayerTableViewCell
            //controller.performSegueWithIdentifier("showGame", sender: cell)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func updateFriendsList(){
        ServerCommunicator.getFriendsList{
            array, success in
            if success{
                self.friends = array!
            }
            else{
                println("pizda")
            }
        }
    }
    
    override init(){
        super.init()
        updateFriendsList()
    }
}