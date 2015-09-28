//
//  GameTableViewCell.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameNameLabel: UILabel!
    var type: GameType!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
