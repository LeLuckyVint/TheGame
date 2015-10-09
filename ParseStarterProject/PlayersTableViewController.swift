//
//  PlayersTableViewController.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    var typeOfGame: GameType!
    
    let reachability = Reachability.reachabilityForInternetConnection()
    let token = NSUserDefaults.standardUserDefaults().stringForKey("token")
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var friends: [User] = []
    var invites: [Invite] = []
    
    let profileIdentifier = "playerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = Standart.purpleColor
        var backgroundView =  UIView(frame: CGRectZero)
        //self.tableView.backgroundColor = Standart.purpleColor
        self.tableView.tableFooterView = backgroundView
        
        if self.revealViewController() != nil {
            self.revealViewController().rightViewController = nil
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        ServerCommunicator.getInvitesFriendsList{
            array, success in
            if success{
                self.invites = array!
                self.tableView.reloadData()
            }
        }
        ServerCommunicator.getFriendsList{
            array, success in
            if success{
                self.friends = array
                self.tableView.reloadData()
            }
            else{
                println("pizda")
            }
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return invites.count
        }
        else{
            return friends.count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Invites"
        }
        else{
            return "Friends"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0{
            let inviteCell = tableView.dequeueReusableCellWithIdentifier("inviteCell", forIndexPath: indexPath) as! InviteTableViewCell
            
            // Configure the cell
            let invite = invites[indexPath.row]
            
            inviteCell.usernameLabel.text = invite.creator.username
            inviteCell.avatarImageView.image = invite.creator.avatar
            inviteCell.userId = invite.inivteId
            
            cell = inviteCell
        }
        else{
            let playerCell = tableView.dequeueReusableCellWithIdentifier(profileIdentifier, forIndexPath: indexPath) as! PlayerTableViewCell
            // Configure the cell
            let friend = friends[indexPath.row]
            
            playerCell.usernameLabel.text = friend.username
            playerCell.avatarImageView.image = friend.avatar
            playerCell.emailLabel.text = friend.email
            playerCell.friendId = friend.id
            
            cell = playerCell
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if typeOfGame != nil{
            if indexPath.section == 1{
                let player = friends[indexPath.row]
                ServerCommunicator.createRoom(player.id, type: typeOfGame.getStringForJSON()){
                    success in
                    if success{
                        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("roomsViewController") as! RoomsTableViewController
                        let navController = UINavigationController(rootViewController: newViewController)
                        self.presentViewController(navController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
