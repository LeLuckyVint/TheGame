//
//  RoomInvite.swift
//  The Game
//
//  Created by demo on 21.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
class RoomInvite {
    let id: Int
    let creator: User

    let type: GameType
    
    init(id: Int, creator: User, type: GameType){
        self.id = id
        self.creator = creator
        self.type = type
    }
}