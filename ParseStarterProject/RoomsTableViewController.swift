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
    var invites = [RoomInvite]()
    var enteredRooms = [RoomInvite]()
    
    let games = [GameType.PUZZLE]
    var game: Game!
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
        
        if reachability.isReachable(){
            ServerCommunicator.getProfile()
            ServerCommunicator.getRoomInvites{
                array, success in
                if success{
                    self.invites = array
                    self.tableView?.reloadData()
                }
            }
            ServerCommunicator.getRooms(){
                array, invitesArr, success in
                if success{
                    self.rooms = array!
                    self.tableView.reloadData()
                    self.enteredRooms = invitesArr!
                    self.tableView?.reloadData()
                }
            }
            //self.tableView?.reloadData()
        }
        else{
            Reachability.showAlert(self)
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
        return rooms.count + invites.count + enteredRooms.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == rooms.count + invites.count + enteredRooms.count{
            var cell = tableView.dequeueReusableCellWithIdentifier("newRoomCell", forIndexPath: indexPath) as! NewRoomTableViewCell
            return cell
        }
        else if indexPath.row >= invites.count + enteredRooms.count && indexPath.row < rooms.count + invites.count + enteredRooms.count && rooms.count != 0{
            var cell = tableView.dequeueReusableCellWithIdentifier("roomCell", forIndexPath: indexPath) as! RoomTableViewCell
            // Configure the cell
            let room = rooms[indexPath.row - enteredRooms.count - invites.count]
            let opponent = Player.getOpponent(room.players)
            let you = Player.getYourself(room.players)
            
            if let avatar = opponent.user.avatar{
                cell.avatarImageView.image = avatar
            }
            else{
                cell.avatarImageView.image = UIImage(named: "no_user")
            }
            cell.usernameLabel.text = opponent.user.username
            cell.yourScoreLabel.text = "\(you.score) -"
            cell.opponentScoreLabel.text = "\(opponent.score)"
            
            return cell
        }
        else if indexPath.row >= invites.count && indexPath.row < rooms.count + invites.count && enteredRooms.count != 0{
            var cell = tableView.dequeueReusableCellWithIdentifier("enteredRoomCell", forIndexPath: indexPath) as! EnteredRoomTableViewCell
            
            let invite = enteredRooms[indexPath.row - invites.count]
            
            cell.usernameLabel.text = invite.creator.username
            cell.avatarImageView.image = UIImage(data: NSData(contentsOfURL: invite.creator.avatarURL!)!)
            cell.roomId = invite.id
            return cell
        }
        else{
            var cell = tableView.dequeueReusableCellWithIdentifier("roomInviteCell", forIndexPath: indexPath) as! RoomInviteTableViewCell
            
            let invite = invites[indexPath.row]
            
            cell.usernameLabel.text = invite.creator.username
            cell.avatarImageView.image = UIImage(data: NSData(contentsOfURL: invite.creator.avatarURL!)!)
            cell.roomId = invite.id
            cell.vc = self
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if reachability.isReachable(){
            //If tapped add new game button
            if indexPath.row == rooms.count + enteredRooms.count + invites.count{
                self.performSegueWithIdentifier("showGames", sender: self)
            }
                //tapped room
            else if indexPath.row >= invites.count + enteredRooms.count && indexPath.row < rooms.count + invites.count + enteredRooms.count && rooms.count != 0{
                let room = rooms[indexPath.row - invites.count - enteredRooms.count]
                ServerCommunicator.getInfoAboutPuzzleGame(room.gameId){
                    success, game in
                    if success{
                        self.game = game!
                        self.performSegueWithIdentifier("startGame", sender: nil)
                    }
                }
            }
                //Tapped invite to room
            else if indexPath.row >= invites.count && indexPath.row < rooms.count + invites.count && enteredRooms.count != 0{
                
            }
            else{
                
            }
        }
            //If internet is OFF
        else{
            Reachability.showAlert(self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? GameViewController{
            destination.game = self.game
        }
        
    }
}
