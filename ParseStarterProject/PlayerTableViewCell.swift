//
//  PlayerTableViewCell.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var friendId: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.borderWidth=1.0
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarImageView.layer.cornerRadius = 13
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
        avatarImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
