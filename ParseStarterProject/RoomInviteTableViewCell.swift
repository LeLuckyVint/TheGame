//
//  RoomInviteTableViewCell.swift
//  The Game
//
//  Created by demo on 21.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class RoomInviteTableViewCell: RoomTableViewCell {
    @IBOutlet weak var inviteImageView: UIView!
    
    var roomId: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
