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
    let creatorId: Int
    let gameId: Int
    
    var players: [Player]
    let type: GameType
    
    init(id: Int, creatorId: Int, gameId: Int, players: [Player], type: GameType){
        self.id = id
        self.creatorId = creatorId
        self.gameId = gameId
        self.players = players
        self.type = type
    }
}