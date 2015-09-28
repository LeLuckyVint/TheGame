//
//  RoomTableViewCell.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var somestuffImageView: UIImageView!
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!

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
