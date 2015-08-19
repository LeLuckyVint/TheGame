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
            
            let creator = room["creator"]
            let creatorId = creator["id"].int!
            let creatorUsername = creator["username"].string!
            let creatorAvatar = creator["avatar"].object as? NSURL
            let creatorEntity = User(id: creatorId, username: creatorUsername, avatar: creatorAvatar)
            
            let gameId = room["gameId"].int!
            
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
            let type = room["type"].string!.toGameType()
            
            let roomEntity = Room(id: roomId, creator: creatorEntity, gameId: gameId, players: playersEntities, type: type)
            rooms.append(roomEntity)
        }
        return rooms
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
                avatarURL = nil
            }
            invites.append(Invite(id: inviteId, creator: User(id: userId, username: username, avatar: avatarURL)))
        }
        return invites
    }
    
    func getCurrentUser(json: JSON) -> User{
        println(json)
        let id = json["id"].int!
        let username = json["username"].string!
        let email = json["email"].string!
        let avatar = json["avatar"].object as? NSURL
        
        return User(id: id, username: username, avatar: avatar,email: email)
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