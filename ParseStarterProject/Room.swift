//
//  Room.swift
//  The Game
//
//  Created by Vitaly on 02.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

class Room {
    let id: Int
    let creator: User
    let gameId: Int
    
    var players: [Player]
    let type: GameType
    
    init(id: Int, creator: User, gameId: Int, players: [Player], type: GameType){
        self.id = id
        self.creator = creator
        self.gameId = gameId
        self.players = players
        self.type = type
    }
}