//
//  GameType.swift
//  The Game
//
//  Created by Vitaly on 02.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
enum GameType: String{
    case PUZZLE = "Puzzle"
    case ERROR = "Error"

    static func count() -> Int{
        return 1
    }
    func getColor() -> UIColor{
        if self == .PUZZLE{
            return UIColor(red: 218/255, green: 88/255, blue: 43/255, alpha: 1)
        }
        else{
            return UIColor.redColor()
        }
    }
    func getStringForJSON() -> String{
        if self == .PUZZLE{
            return "PUZZLE"
        }
        else{
            return "ERROR"
        }
    }
}