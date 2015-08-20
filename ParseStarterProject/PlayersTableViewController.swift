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

    let friendsDataSource = PlayersDataSourceDelegate()
    let invitesDataSource = InvitesDataSourceDelegate()
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.selectedSegmentIndex = 0
        friendsDataSource.controller = self
        invitesDataSource.controller = self
        
        self.tableView.delegate = friendsDataSource
        self.tableView.dataSource = friendsDataSource
        
        var backgroundView =  UIView(frame: CGRectZero)
        self.tableView.backgroundColor = Standart.purpleColor
        self.tableView.tableFooterView = backgroundView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        //FRIENDS
        if sender.selectedSegmentIndex ==  0{
            friendsDataSource.updateFriendsList()
            self.tableView.dataSource = friendsDataSource
            self.tableView.delegate = friendsDataSource
        }
        //INVITES
        else{
            invitesDataSource.updateInvitesList()
            self.tableView.dataSource = invitesDataSource
            self.tableView.delegate = invitesDataSource
        }
        self.tableView.reloadData()
    }
}
