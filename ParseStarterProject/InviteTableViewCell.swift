//
//  InviteTableViewCell.swift
//  The Game
//
//  Created by demo on 21.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class InviteTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var userId: Int!
    var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func acceptInvite(sender: UIButton) {
        ServerCommunicator.acceptInviteFromUserWithId(userId!)
        tableView.reloadData()
    }

    @IBAction func declineInvite(sender: UIButton) {
        ServerCommunicator.acceptInviteFromUserWithId(userId)
        tableView.reloadData()
    }
}
