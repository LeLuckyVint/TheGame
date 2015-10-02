//
//  MenuViewController.swift
//  The Game
//
//  Created by demo on 28.09.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MaterialKit

class MenuViewController: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var menuTableView: UITableView!
    
    @IBOutlet weak var profileCell: UITableViewCell!
    @IBOutlet weak var friendsCell: MKTableViewCell!
    @IBOutlet weak var gamesCell: MKTableViewCell!
    @IBOutlet weak var invitesCell: MKTableViewCell!
    @IBOutlet weak var settingsCell: UITableViewCell!
    
    var presentedRow = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //adding circular shape to avatar
        avatarImageView.layer.borderWidth=1.0
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarImageView.layer.cornerRadius = 13
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
        avatarImageView.clipsToBounds = true
        //self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    func update(){
        avatarImageView.image = User.currentUser?.avatar
        nameLabel.text = User.currentUser?.username
    }
    override func viewWillAppear(animated: Bool) {
        update()

        clearRowColors()
        if presentedRow == 1{
            profileCell.contentView.backgroundColor = UIColor.grayColor()
        }
        else if presentedRow == 2{
            friendsCell.contentView.backgroundColor = UIColor.grayColor()
        }
        else if presentedRow == 3{
            gamesCell.contentView.backgroundColor = UIColor.grayColor()
        }
        else if presentedRow == 4{
            invitesCell.contentView.backgroundColor = UIColor.grayColor()
        }
        else if presentedRow == 5{
            settingsCell.contentView.backgroundColor = UIColor.grayColor()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func clearRowColors(){
        for i in 1...8{
            if i == 1{
                profileCell.contentView.backgroundColor = UIColor.whiteColor()
            }
            else if i == 2{
                friendsCell.contentView.backgroundColor = UIColor.whiteColor()
            }
            else if i == 3{
                gamesCell.contentView.backgroundColor = UIColor.whiteColor()
            }
            else if i == 4{
                invitesCell.contentView.backgroundColor = UIColor.whiteColor()
            }
            else if i == 5{
                settingsCell.contentView.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    /**
    Method that handles selection of the menu items
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        //If tapped item which are already presented, then just show it without creating new one
        if row == presentedRow{
            self.revealViewController().revealToggle(nil)
            return
        }
            //else create new view and show it
        else{
            var newFrontViewController: UIViewController!
            
            if row == 1{
                //newFrontViewController = self.storyboard?.instantiateViewControllerWithIdentifier("profile") as! ProfileViewController
            }
                //Show map view
            else if row == 2{
                newFrontViewController = self.storyboard?.instantiateViewControllerWithIdentifier("friends") as! PlayersTableViewController
            }
                //Show settings view
            else if row == 3{
                newFrontViewController = self.storyboard?.instantiateViewControllerWithIdentifier("roomsViewController") as! RoomsTableViewController
            }
                //Show history view
            else if row == 4{
                newFrontViewController = self.storyboard?.instantiateViewControllerWithIdentifier("invitesViewController") as! RoomInvitesTableViewController
            }
            else if row == 5{
                //newFrontViewController = self.storyboard?.instantiateViewControllerWithIdentifier("history") as! HistoryTableViewController
            }
            
            let navController = UINavigationController(rootViewController: newFrontViewController)
            
            self.revealViewController().pushFrontViewController(navController, animated: true)
            presentedRow = row
        }
    }
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        clearRowColors()
        return indexPath
    }
}
