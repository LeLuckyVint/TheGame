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
    var column: Int?
    var row: Int?
    var sprite: SKSpriteNode?
    
    public init(type: Type, color: Color){
        self.type = type
        self.color = color
        //self.column = nil
        //self.row = nil
    }
    
    public func placeFigureAtRow(row: Int, Column column: Int){
        self.column = column
        self.row = row
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