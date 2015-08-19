//
//  InvitesDataSourceDelegate.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class InvitesDataSourceDelegate:NSObject, UITableViewDataSource, UITableViewDelegate {
    var invites: [Invite] = []
    let profileIdentifier = "playerCell"
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(profileIdentifier, forIndexPath: indexPath) as! PlayerTableViewCell
        
        // Configure the cell
        let invite = invites[indexPath.row]
        
        cell.usernameLabel.text = invite.creator.username
        cell.avatarImageView.image = invite.creator.avatar
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func updateInvitesList(){
        ServerCommunicator.getInvitesFriendsList{
            array, success in
            if success{
                self.invites = array!
            }
        }
    }
}