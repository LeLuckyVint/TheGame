//
//  RoomsTableViewController.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class RoomsTableViewController: UITableViewController {
    let jsonParser = JSONParser.sharedInstance
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var rooms = [Room]()
    let games = [GameType.PUZZLE]
    
    let reachability = Reachability.reachabilityForInternetConnection()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = Standart.purpleColor
        reachability.whenUnreachable = { reachability in
            Reachability.showAlert(self)
        }
        var backgroundView =  UIView(frame: CGRectZero)
        self.tableView.backgroundColor = Standart.purpleColor
        self.tableView.tableFooterView = backgroundView
        reachability.startNotifier()

        if let token = defaults.stringForKey("token")
        {
            if reachability.isReachable(){
                ServerCommunicator.getProfile(token)
                if let roomsFromServer = ServerCommunicator.getRooms(token){
                    rooms = roomsFromServer
                    self.tableView?.reloadData()
                }
                else{
                    rooms = []
                }
            }
            else{
                Reachability.showAlert(self)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == rooms.count{
            var cell = tableView.dequeueReusableCellWithIdentifier("newRoomCell", forIndexPath: indexPath) as! NewRoomTableViewCell
            return cell
        }
        else{
            var cell = tableView.dequeueReusableCellWithIdentifier("roomCell", forIndexPath: indexPath) as! RoomTableViewCell
            // Configure the cell
            let room = rooms[indexPath.row]
            let opponent = Player.getOpponent(room.players)
            let you = Player.getYourself(room.players)
            
            if let avatar = opponent.user.avatar{
                cell.avatarImageView.image = avatar
            }
            else{
                cell.avatarImageView.image = UIImage(named: "no_user")
            }
            cell.usernameLabel.text = opponent.user.username
            cell.yourScoreLabel.text = "\(you.score)"
            cell.opponentScoreLabel.text = "\(opponent.score)"
            
            return cell
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if reachability.isReachable(){
            //If tapped add new game button
            if indexPath.row == rooms.count{
                self.performSegueWithIdentifier("showGames", sender: self)
            }
                //Tapped existed room
            else{
                
            }
        }
            //If internet is OFF
        else{
            Reachability.showAlert(self)
        }

    }
}
