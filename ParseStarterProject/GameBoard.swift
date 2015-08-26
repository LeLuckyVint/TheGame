//
//  GameBoard.swift
//  Muzzle
//
//  Created by Vitaly on 06.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import Foundation

let colNumber = 15
let rowNumber = 15
let handNumber = 7
class GameBoard{
    var figuresArray = Array2D<Figure>(columns: colNumber, rows: rowNumber)
    var currentMoveFiguresArray = Array2D<Figure>(columns: colNumber, rows: rowNumber)
    
    private var tiles = Array2D<Tile>(columns: colNumber, rows: rowNumber)
    
    var hand: [Figure?] = [nil, nil, nil, nil, nil, nil, nil]
    var handCount: Int{
        var count = 0
        for i in hand{
            if i != nil{
                count += 1
            }
        }
        return count
    }
    
    var handLackOfFigures: Int{
        return handNumber - handCount
    }
    func tileAtColumn(column: Int, row: Int) -> Tile? {
        assert(column >= 0 && column < colNumber)
        assert(row >= 0 && row < rowNumber)
        return tiles[column, row]
    }
    
    func setFigureAtColumn(column: Int, row: Int, figure: Figure?)
    {
        assert(column >= 0 && column < colNumber)
        assert(row >= 0 && row < rowNumber)
        figuresArray[column, row] = figure
    }
    
    func figureAtColumn(column: Int, row: Int) -> Figure? {
        assert(column >= 0 && column < colNumber)
        assert(row >= 0 && row < rowNumber)
        return figuresArray[column, row]
    }
    
    func setUpNewGameBoard(){
        for row in 0..<rowNumber {
            for column in 0..<colNumber {
                figuresArray[column, row] = nil
                tiles[column,row] = Tile()
            }
        }

//        hand[0] = Figure(type: Type.CIRCLE, color: Color.RED)
//        hand[1] = Figure(type: Type.CIRCLE, color: Color.BLUE)
//        hand[2] = Figure(type: Type.CIRCLE, color: Color.BLUE)
//        hand[3] = Figure(type: Type.CIRCLE, color: Color.BLUE)
//        hand[4] = Figure(type: Type.CIRCLE, color: Color.BLUE)
//        hand[5] = Figure(type: Type.CIRCLE, color: Color.BLUE)
//        hand[6] = Figure(type: Type.CIRCLE, color: Color.ORANGE)
    }
    
    func clearCurrentMoveArray(){
        for row in 0..<rowNumber {
            for column in 0..<colNumber {
                currentMoveFiguresArray[column, row] = nil
            }
        }
    }
    
    func takeFiguresToHand(){
        for i in 0..<handLackOfFigures{
            hand[handNumber - i - 1] = Figure.getRandomFigure()
        }
    }
    
    func moveHandFiguresToRight(){
        var freeIndex = 0
        var foundFreeSpace = false
        var i = 0
        while i < handNumber{
            if hand[i] == nil{
                if !foundFreeSpace{
                    freeIndex = i
                    foundFreeSpace = true
                }
            }
            else{
                if foundFreeSpace{
                    hand[freeIndex] = hand[i]
                    hand[i] = nil
                    i = freeIndex
                    foundFreeSpace = false
                }
            }
            i += 1
        }
    }
    init(){
        setUpNewGameBoard()
    }
}