//
//  JSONParser.swift
//  The Game
//
//  Created by Vitaly on 02.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONParser {
    static let sharedInstance = JSONParser()
    
    func getRooms(json: JSON) -> [Room]{
        var rooms:[Room] = []
        let roomsJSONArray = json.arrayValue
        for room in roomsJSONArray{
            let roomId = room["roomId"].int!
            let gameId = room["gameId"].int!
            let creatorId = room["creatorId"].int!
            let type = room["type"].string!.toGameType()
            let currentPlayerId = room["currentPlayerId"].int!
            let lastChange = room["lastChange"].string!
            
            var players = room["players"].array!
            var playersEntities:[Player] = []
            
            for player in players{
                let score = player["score"].intValue
                let skippedMoveNumber = player["skippedMoveNumber"].intValue
                
                let user = player["user"]
                let userId = user["id"].intValue
                let userUsername = user["username"].stringValue
                let userAvatar = user["avatar"].object as? NSURL
                let userEntity = User(id: userId, username: userUsername, avatar: userAvatar)
                
                let playerEntity = Player(user: userEntity, score: score, skippedMoveNumber: skippedMoveNumber)
                playersEntities.append(playerEntity)
            }
            
            let lastTurn = room["lastTurn"]
            if lastTurn != nil{
                let turnId = lastTurn["turnId"].intValue
                let playerId = lastTurn["playerId"].intValue
                let addedScore = lastTurn["addedScore"].intValue
            }
            
            let roomEntity = Room(id: roomId, creatorId: creatorId, gameId: gameId, players: playersEntities, type: type)
            rooms.append(roomEntity)
        }
        return (rooms: rooms)
    }
    
    func getRoomInvites(json: JSON) -> [RoomInvite]{
        var invites: [RoomInvite] = []
        
        let invitesJsonArray = json.arrayValue
        
        for inviteJSON in invitesJsonArray{
            let roomId = inviteJSON["roomId"].intValue
            let userId = inviteJSON["creator"]["id"].intValue
            let username = inviteJSON["creator"]["username"].stringValue
            let avatarString = inviteJSON["creator"]["avatar"].string
            let avatarURL: NSURL?
            if let avatarString = avatarString{
                avatarURL = NSURL(string: avatarString)
            }
            else{
                avatarURL = NSURL(string: "http://cs623318.vk.me/v623318367/1eab5/rCiTafl2x_s.jpg")
            }
            let type = inviteJSON["type"].stringValue
            let room = RoomInvite(id: roomId, creator: User(id: userId, username: username, avatar: avatarURL), type: GameType.getTypeFromString(type))
            invites.append(room)
        }
        return invites
    }
    
    func getInfoAboutPuzzleRoom(json: JSON) -> Game{
        let gameId = json["gameId"].intValue
        let size = json["size"].intValue
        let ended = json["ended"].boolValue
        let locked = json["locked"].boolValue
        
        var players = json["players"].arrayValue
        var playersEntities:[Player] = []
        
        for player in players{
            let score = player["score"].intValue
            let skippedMoveNumber = player["skippedMoveNumber"].intValue
            
            let user = player["user"]
            let userId = user["id"].intValue
            let userUsername = user["username"].stringValue
            let userAvatar = user["avatar"].object as? NSURL
            let userEntity = User(id: userId, username: userUsername, avatar: userAvatar)
            
            let playerEntity = Player(user: userEntity, score: score, skippedMoveNumber: skippedMoveNumber)
            playersEntities.append(playerEntity)
        }
        
        var figures = json["figures"].dictionaryValue
        var figuressEntities = Array2D<Figure>(columns: size, rows: size)
        
        for figure in figures{
            let coord = figure.0.toInt()
            let figurejson = figure.1
            let fig = Figure(type: Type.getTypeFromString(figurejson["type"].stringValue), color: Color.getTypeFromString(figurejson["color"].stringValue))
            let row = Int(coord!/size)
            let col = coord! - row*size
            figuressEntities[col, row] = fig
        }
        
        let bonuses = json["bonuses"]
        var bonusesEntities: [Bonus] = []
        for bonus in bonuses{
            let coord = bonus.0.toInt()
            let type = bonus.1.int
            bonusesEntities.append(Bonus(coordinate: coord!, type: type!))
        }
        
        var handArray = json["hand"].arrayValue
        var hand: [Figure?] = []
        for handJson in handArray{
            let type = Type.getTypeFromString(handJson["type"].stringValue)
            let color = Color.getTypeFromString(handJson["color"].stringValue)
            hand.append(Figure(type: type, color: color))
        }
        
        let currentPlayer = json["currentPlayer"].intValue
        return Game(ended: ended, locked: locked, size: size, figures: figuressEntities, hand: hand, currentPlayerId: currentPlayer, gameId: gameId, players: playersEntities, bonuses: bonusesEntities)
        
    }
    
    func getFriends(json: JSON) -> [User]{
        var friends: [User] = []
        
        let friendsJSONArray = json.arrayValue
        for friendJSON in friendsJSONArray{
            let id = friendJSON["id"].int!
            let username = friendJSON["username"].stringValue
            let email = friendJSON["email"].stringValue
            let avatarString = friendJSON["avatar"].string
            let avatarURL: NSURL?
            if let avatarString = avatarString{
                avatarURL = NSURL(string: avatarString)
            }
            else{
                avatarURL = nil
            }
            
            friends.append(User(id: id, username: username, avatar: avatarURL, email: email))
        }
        return friends
    }
    
    func getInvitesList(json: JSON) -> [Invite]{
        var invites: [Invite] = []
        let invitesJSONArray = json.arrayValue
        for inviteJSON in invitesJSONArray{
            let inviteId = inviteJSON["inviteId"].intValue
            let userId = inviteJSON["creator"]["id"].intValue
            let username = inviteJSON["creator"]["username"].stringValue
            let avatarString = inviteJSON["creator"]["avatar"].string
            let avatarURL: NSURL?
            if let avatarString = avatarString{
                avatarURL = NSURL(string: avatarString)
            }
            else{
                avatarURL = NSURL(string: "http://cs623318.vk.me/v623318367/1eab5/rCiTafl2x_s.jpg")
            }
            invites.append(Invite(id: inviteId, creator: User(id: userId, username: username, avatar: avatarURL)))
        }
        return invites
    }
    
    func getCurrentUser(json: JSON) -> (user: User?, success: Bool){
        if let code = json["code"].int{
            return (nil, false)
        }
        else{
            let id = json["id"].int!
            let username = json["username"].string!
            let email = json["email"].string!
            let avatar = json["avatar"].object as? NSURL
            
            return (User(id: id, username: username, avatar: avatar,email: email), true)
        }
    }
    
    func getUsersFromSearch(json: JSON) -> [User]{
        var users: [User] = []
        let usersJSON = json.arrayValue
        for userJSON in usersJSON{
            let id = userJSON["id"].intValue
            let username = userJSON["username"].string!
            let email = userJSON["email"].string!
            let avatar = userJSON["avatar"].object as? NSURL
            users.append(User(id: id, username: username, avatar: avatar,email: email))
        }
        return users
    }
    
    func getHandFromChangeHand(json: JSON) -> [Figure]{
        var hand: [Figure] = []
        let handJson = json["hand"]
        
        return hand
    }
}
extension String{
    func toGameType() -> GameType{
        if self == "PUZZLE"{
            return GameType.PUZZLE
        }
        else{
            return GameType.ERROR
        }
    }
    
}