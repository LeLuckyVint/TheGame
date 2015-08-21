//
//  Game.swift
//  The Game
//
//  Created by demo on 21.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

class Game: Room{
    var ended: Bool
    var locked: Bool
    var size: Int
    var figures: Array2D<Figure>
    //var bonuses: Array
    var hand: [Figure]
    var currentPlayerId: Int
    
    init(ended: Bool, locked: Bool, size: Int, figures: Array2D<Figure>, hand: [Figure], currentPlayerId: Int){
        super.init(id: super.id, creator: super.creator, gameId: super.id, players: super.players, type: super.type)
        self.ended = ended
        self.locked = locked
        self.size = size
        self.figures = figures
        self.hand = hand
        self.currentPlayerId = currentPlayerId
    }
}