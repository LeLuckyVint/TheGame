//
//  Player.swift
//  Muzzle
//
//  Created by Vitaly on 06.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import Foundation

class Player {
    var score: Int
    var skippedMoveNumber: Int
    let user: User
    
    init(user: User){
        self.user = user
        self.score = 0
        self.skippedMoveNumber = 0
        
    }
    init(user: User, score: Int, skippedMoveNumber: Int){
        self.user = user
        self.skippedMoveNumber = skippedMoveNumber
        self.score = score
    }
    
    static func getOpponent(players: [Player]) -> Player{
        let playerOne = players[0]
        let playerTwo = players[1]
        
        if playerOne.user.id == User.currentUser!.id{
            return playerOne
        }
        else {
            return playerTwo
        }
    }
    
    static func getYourself(players: [Player]) -> Player{
        let playerOne = players[0]
        let playerTwo = players[1]
        
        if playerOne.user.id != User.currentUser!.id{
            return playerOne
        }
        else {
            return playerTwo
        }
    }
}