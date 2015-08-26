//
//  EnteredRoomTableViewCell.swift
//  The Game
//
//  Created by Vitaly on 22.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class EnteredRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var roomId: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
