//
//  Game.swift
//  The Game
//
//  Created by demo on 21.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

class Game{
    var ended: Bool
    var locked: Bool
    var size: Int
    var figures: Array2D<Figure>
    //var bonuses: Array
    var hand: [Figure?]
    var currentPlayerId: Int
    var gameId: Int
    var you: Player
    var opponent: Player
    var bonuses: [Bonus]
    
    init(ended: Bool, locked: Bool, size: Int, figures: Array2D<Figure>, hand: [Figure?], currentPlayerId: Int, gameId: Int, players: [Player], bonuses: [Bonus]){
        //super.init(id: id, creator: creator, gameId: id, players: players, type: type)
        self.ended = ended
        self.locked = locked
        self.size = size
        self.figures = figures
        self.hand = hand
        self.currentPlayerId = currentPlayerId
        self.gameId = gameId
        self.you = Player.getYourself(players)
        self.opponent = Player.getOpponent(players)
        self.bonuses = bonuses
    }
}