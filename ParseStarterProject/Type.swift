//
//  Type.swift
//  Muzzle
//
//  Created by Vitaly on 06.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import Foundation

public enum Type{
    case TRIANGLE
    case CIRCLE
    case STAR
    case CHRIS
    case MOON
    case HEART
    
    public static let size = 6
    public static let unicode: [String] = [
        "\u{25B3}",
        "\u{25CB}",
        "\u{2606}",
        "\u{2716}",
        "\u{263E}",
        "\u{2764}"]
    
    public var string: String{
        if self == .TRIANGLE{
            return "Triangle"
        }
        if self == .CIRCLE{
            return "Circle"
        }
        if self == .STAR{
            return "Star"
        }
        if self == .CHRIS{
            return "Chris"
        }
        if self == .MOON{
            return "Moon"
        }
        if self == .HEART{
            return "Heart"
        }
        return ""
    }
    public var stringForServer: String{
        if self == .TRIANGLE{
            return "TRIANGLE"
        }
        if self == .CIRCLE{
            return "CIRCLE"
        }
        if self == .STAR{
            return "STAR"
        }
        if self == .CHRIS{
            return "CROSS"
        }
        if self == .MOON{
            return "MOON"
        }
        if self == .HEART{
            return "HEART"
        }
        return ""
    }
    
    public static func getTypeFromString(type: String) -> Type{
        switch (type){
            case "TRIANGLE":
                return .TRIANGLE
            case "CIRCLE":
                return .CIRCLE
            case "STAR":
                return .STAR
            case "CROSS":
                return .CHRIS
            case "MOON":
                return .MOON
            case "HEART":
                return .HEART
        default:
            return .MOON
        }
    }
}