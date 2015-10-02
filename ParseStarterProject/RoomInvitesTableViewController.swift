//
//  RoomInvitesTableViewController.swift
//
//
//  Created by demo on 02.10.15.
//
//

import UIKit

class RoomInvitesTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let jsonParser = JSONParser.sharedInstance
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var invites = [RoomInvite]()
    
    let reachability = Reachability.reachabilityForInternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = Standart.purpleColor
        
        if self.revealViewController() != nil {
            self.revealViewController().rightViewController = nil
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        reachability.whenUnreachable = { reachability in
            Reachability.showAlert(self)
        }
        var backgroundView =  UIView(frame: CGRectZero)
        self.tableView.backgroundColor = Standart.purpleColor
        self.tableView.tableFooterView = backgroundView
        reachability.startNotifier()
        
        if reachability.isReachable(){
            ServerCommunicator.getRoomInvites{
                rooms, success in
                if success{
                    self.invites = rooms
                    self.tableView.reloadData()
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
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invites.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var inviteCell = tableView.dequeueReusableCellWithIdentifier("roomInviteCell", forIndexPath: indexPath) as! EnteredRoomTableViewCell
        
        let invite = invites[indexPath.row]
        
        inviteCell.usernameLabel.text = invite.creator.username
        inviteCell.avatarImageView.image = UIImage(data: NSData(contentsOfURL: invite.creator.avatarURL!)!)
        inviteCell.roomId = invite.id
        
        return inviteCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let invite = invites[indexPath.row]
        let delete = UITableViewRowAction(style: .Normal, title: "X") { action, index in
            ServerCommunicator.declineInviteToGame(invite.id){
                success in
                self.tableView.reloadData()
            }
        }
        let accept = UITableViewRowAction(style: .Normal, title: "V") { action, index in
            ServerCommunicator.acceptInviteToGame(invite.id){
                success in
                self.tableView.reloadData()
            }
        }
        
        delete.backgroundColor = Standart.redColorForDecline
        accept.backgroundColor = Standart.greenColorForAccept
        return [accept, delete]
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
