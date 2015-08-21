//
//  RoomInviteTableViewCell.swift
//  The Game
//
//  Created by demo on 21.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class RoomInviteTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    var roomId: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func accept(sender: UIButton) {
        ServerCommunicator.acceptInviteToGame(roomId!){
            success in
            
        }
    }
    
    @IBAction func decline(sender: UIButton) {
        ServerCommunicator.declineInviteFromUserWithId(roomId!){
            success in
            
        }
    }
}
