//
//  Bonus.swift
//  The Game
//
//  Created by demo on 09.10.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

class Bonus{
    var type: Int
    var row: Int
    var col: Int
    
    init(coordinate: Int, type: Int){
        self.row = Int(coordinate/colNumber)
        self.col = coordinate - row*rowNumber
        self.type = type
    }
}