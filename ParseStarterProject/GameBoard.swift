//
//  GameBoard.swift
//  Muzzle
//
//  Created by Vitaly on 06.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import Foundation

let colNumber = 10
let rowNumber = 10
let handNumber = 7
class GameBoard{
    var figuresArray = Array2D<Figure>(columns: colNumber, rows: rowNumber)
    var currentMoveFiguresArray = Array2D<Figure>(columns: colNumber, rows: rowNumber)
    
    private var tiles = Array2D<Tile>(columns: colNumber, rows: rowNumber)
    
    var hand: [Figure?] = [nil, nil, nil, nil, nil, nil, nil]
    
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
        
        figuresArray[1,1] = Figure(type: Type.CHRIS, color: Color.YELLOW)
        figuresArray[1,1]?.placeFigureAtRow(1, Column: 1)
        figuresArray[3,1] = Figure(type: Type.HEART, color: Color.CYAN)
        figuresArray[3,1]?.placeFigureAtRow(3, Column: 1)
        figuresArray[2,1] = Figure(type: Type.CHRIS, color: Color.YELLOW)
        figuresArray[2,1]?.placeFigureAtRow(2, Column: 1)
        figuresArray[4,1] = Figure(type: Type.CHRIS, color: Color.YELLOW)
        figuresArray[4,1]?.placeFigureAtRow(4, Column: 1)
        figuresArray[4,2] = Figure(type: Type.CHRIS, color: Color.YELLOW)
        figuresArray[4,2]?.placeFigureAtRow(4, Column: 2)
        figuresArray[2,2] = Figure(type: Type.CHRIS, color: Color.YELLOW)
        figuresArray[2,2]?.placeFigureAtRow(2, Column: 2)
        figuresArray[4,3] = Figure(type: Type.CHRIS, color: Color.YELLOW)
        figuresArray[4,3]?.placeFigureAtRow(4, Column: 3)
        figuresArray[4,4] = Figure(type: Type.CHRIS, color: Color.YELLOW)
        figuresArray[4,4]?.placeFigureAtRow(4, Column: 4)
        hand[0] = Figure(type: Type.CIRCLE, color: Color.RED)
        hand[1] = Figure(type: Type.CIRCLE, color: Color.BLUE)
        hand[2] = Figure(type: Type.CIRCLE, color: Color.BLUE)
        hand[3] = Figure(type: Type.CIRCLE, color: Color.BLUE)
        hand[4] = Figure(type: Type.CIRCLE, color: Color.BLUE)
        hand[5] = Figure(type: Type.CIRCLE, color: Color.BLUE)
        hand[6] = Figure(type: Type.CIRCLE, color: Color.ORANGE)
    }
    
    init(){
        setUpNewGameBoard()
    }
}