//
//  Color.swift
//  Muzzle
//
//  Created by Vitaly on 06.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import Foundation
public enum Color{
    case RED
    case BLUE
    case PINK
    case ORANGE
    case YELLOW
    case GREY
    
    public static var size = 6

    public var string: String{
        if self == .RED{
            return "red"
        }
        if self == .BLUE{
            return "blue"
        }
        if self == .PINK{
            return "pink"
        }
        if self == .ORANGE{
            return "orange"
        }
        if self == .GREY{
            return "grey"
        }
        if self == .YELLOW{
            return "yellow"
        }
        return ""
    }
    
    public var stringForServer: String{
        if self == .RED{
            return "RED"
        }
        if self == .BLUE{
            return "BLUE"
        }
        if self == .PINK{
            return "PINK"
        }
        if self == .ORANGE{
            return "ORANGE"
        }
        if self == .GREY{
            return "GREY"
        }
        if self == .YELLOW{
            return "YELLOW"
        }
        return ""
    }
    
    public static func getTypeFromString(type: String) -> Color{
        switch (type){
        case "RED":
            return .RED
        case "BLUE":
            return .BLUE
        case "PINK":
            return .PINK
        case "ORANGE":
            return .ORANGE
        case "GREY":
            return .GREY
        case "YELLOW":
            return .YELLOW
        default:
            return .RED
        }
    }

}