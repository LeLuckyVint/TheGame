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
    let profileIdentifier = "inviteCell"
    var controller: PlayersTableViewController!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(profileIdentifier, forIndexPath: indexPath) as! InviteTableViewCell
        
        // Configure the cell
        let invite = invites[indexPath.row]
        
        cell.usernameLabel.text = invite.creator.username
        cell.avatarImageView.image = invite.creator.avatar
        cell.userId = invite.inivteId
        cell.tableView = controller.tableView
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func updateInvitesList(){
        ServerCommunicator.getInvitesFriendsList{
            array, success in
            if success{
                self.invites = array!
            }
        }
    }
    override init(){
        super.init()
        updateInvitesList()
    }
}