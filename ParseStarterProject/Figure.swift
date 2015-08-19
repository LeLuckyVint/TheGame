//
//  Figure.swift
//  Muzzle
//
//  Created by Vitaly on 06.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import Foundation
import SpriteKit

public class Figure{
    private var type: Type?
    private var color: Color?
    var sprite: SKSpriteNode?
    
    public init(type: Type, color: Color){
        self.type = type
        self.color = color
        //self.column = nil
        //self.row = nil
    }
    
    public func getType() -> Type! {
        return self.type
    }
    
    private func setType(type: Type){
        self.type = type
    }
    
    public func getColor() -> Color! {
        return self.color
    }
    
    private func setColor (color: Color){
        self.color = color
    }
    public var toString: String{
        if let color = color{
            if let type = type{
                return color.string + type.string
            }
        }
        return ""
    }
    
    static func getRandomFigure() -> Figure{
        let randColor = arc4random_uniform(6)
        let randType = arc4random_uniform(6)
        let type: Type!
        let color: Color!
        switch(randColor){
        case 0: color = .RED
        case 1: color = .BLUE
        case 2: color = .YELLOW
        case 3: color = .CYAN
        case 4: color = .PINK
        case 5: color = .ORANGE
        default:
            color = .RED
        }
        
        switch(randType){
        case 0: type = .MOON
        case 1: type = .CIRCLE
        case 2: type = .CHRIS
        case 3: type = .TRIANGLE
        case 4: type = .STAR
        case 5: type = .HEART
        default:
            type = .HEART
        }
        
        return Figure(type: type, color: color)
    }
}
extension Figure: Hashable{
    public var hashValue: Int{
        let prime: Int = 37
        var result = 1
        result = prime * result + ((color == nil) ? 0 : color!.hashValue)
        result = prime * result + ((type == nil) ? 0 : type!.hashValue)
        return result
    }
}
public func ==(lhv: Figure, rhv: Figure) -> Bool{
    return lhv.color == rhv.color && lhv.type == rhv.type
}