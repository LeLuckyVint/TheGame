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
    case CYAN
    //case GRAY
    
    public static var size = 6
//    public static final var unicode: [String] = [
//        "\u{001B}",
//        "\u{001B}",
//        "\u001B}",
//    "\u001B[33m",
//    "\u001B[32m",
//    "\u001B[34m"
//    ]
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
        if self == .CYAN{
            return "cyan"
        }
        if self == .YELLOW{
            return "yellow"
        }
        return ""
    }
}