//
//  PlayersTableViewController.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {

    var friends: [User]!
    var invites: [Invite]!
    var typeOfGame: GameType!
    
    let reachability = Reachability.reachabilityForInternetConnection()
    let token = NSUserDefaults.standardUserDefaults().objectForKey("token") as! String

    let friendsDataSource = PlayersDataSourceDelegate()
    let invitesDataSource = InvitesDataSourceDelegate()
    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.selectedSegmentIndex = 0
        var backgroundView =  UIView(frame: CGRectZero)
        self.tableView.backgroundColor = Standart.purpleColor
        self.tableView.tableFooterView = backgroundView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        //FRIENDS
        if sender.selectedSegmentIndex ==  0{
            friendsDataSource.updateFriendsList()
            self.tableView.dataSource = friendsDataSource
        }
        //INVITES
        else{
            invitesDataSource.updateInvitesList()
            self.tableView.dataSource = invitesDataSource
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
