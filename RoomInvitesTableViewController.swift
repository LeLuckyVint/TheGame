//
//  RoomInvitesTableViewController.swift
//  
//
//  Created by demo on 02.10.15.
//
//

import UIKit

class RoomInvitesTableViewController: UITableViewController {

    let jsonParser = JSONParser.sharedInstance
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var rooms = [Room]()
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
            ServerCommunicator.getRooms(){
                array, invitesArr, success in
                if success{
                    self.rooms = array!
                    self.tableView.reloadData()
                    self.enteredRooms = invitesArr!
                    self.tableView?.reloadData()
                }
            }
        }
        else{
            Reachability.showAlert(self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newRoom(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showGames", sender: self)
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Games"
        }
        else{
            return "Pending Rooms"
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return rooms.count
        }
        else{
            return enteredRooms.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0{
            var roomCell = tableView.dequeueReusableCellWithIdentifier("roomCell", forIndexPath: indexPath) as! RoomTableViewCell
            // Configure the cell
            let room = rooms[indexPath.row]
            let opponent = Player.getOpponent(room.players)
            let you = Player.getYourself(room.players)
            
            if let avatar = opponent.user.avatar{
                roomCell.avatarImageView.image = avatar
            }
            else{
                roomCell.avatarImageView.image = UIImage(named: "no_user")
            }
            roomCell.usernameLabel.text = opponent.user.username
            roomCell.yourScoreLabel.text = "\(you.score) -"
            roomCell.opponentScoreLabel.text = "\(opponent.score)"
            
            cell = roomCell
        }
        else{
            var enteredRoomCell = tableView.dequeueReusableCellWithIdentifier("roomInviteCell", forIndexPath: indexPath) as! EnteredRoomTableViewCell
            
            let invite = enteredRooms[indexPath.row]
            
            enteredRoomCell.usernameLabel.text = invite.creator.username
            enteredRoomCell.avatarImageView.image = UIImage(data: NSData(contentsOfURL: invite.creator.avatarURL!)!)
            enteredRoomCell.roomId = invite.id
            cell = enteredRoomCell
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if reachability.isReachable(){
            //If tapped add new game button
            
            if indexPath.section == 0{
                let room = rooms[indexPath.row]
                ServerCommunicator.getInfoAboutPuzzleGame(room.gameId){
                    success, game in
                    if success{
                        self.game = game!
                        self.performSegueWithIdentifier("startGame", sender: nil)
                    }
                }
            }
                //Tapped invite to room
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
