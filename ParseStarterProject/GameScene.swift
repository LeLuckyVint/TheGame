//
//  GameScene.swift
//  The Game
//
//  Created by demo on 06.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameBoard: GameBoard!
    let TileWidth: CGFloat = 30.0
    let TileHeight: CGFloat = 30.0
    
    let gameLayer = SKNode()
    let figuresLayer = SKNode()
    let tilesLayer = SKNode()
    let handLayer = SKNode()
    let handTilesLayer = SKNode()
    var background: SKSpriteNode!
    
    var selectedNode: SKSpriteNode? = SKSpriteNode()
    var selectedFigure: Figure?
    var isFromGameBoard = false
    var isFromHand = false
    var startedPosition: CGPoint?
    var movementEnable = false
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let texture = SKTexture(imageNamed: "background")
        background = SKSpriteNode(texture: texture)
        addChild(background)
        
        addChild(gameLayer)
        
        let h = TileHeight * CGFloat(rowNumber)
        let w = TileWidth * CGFloat(colNumber)
        let handWidth = TileWidth * CGFloat(handNumber)
        let layerPosition = CGPoint(x: -w/2, y: -(h - self.size.height/2 + 10))
        let handPosition = CGPoint(x: -handWidth/2, y: -(h - self.size.height/2 + 20 + TileHeight))
        
        
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        
        figuresLayer.position = layerPosition
        gameLayer.addChild(figuresLayer)
        
        handTilesLayer.position = handPosition
        gameLayer.addChild(handTilesLayer)
        
        handLayer.position = handPosition
        gameLayer.addChild(handLayer)
        
        
    }
    
    func addSpritesForFigures(figures: Array2D<Figure>) {
        for row in 0..<rowNumber {
            for column in 0..<colNumber {
                let figure = figures[column, row]
                if figure != nil{
                    let sprite = SKSpriteNode(imageNamed: figure!.toString)
                    sprite.anchorPoint = CGPointZero
                    sprite.name = "figure"
                    sprite.size = CGSize(width: TileWidth, height: TileHeight)
                    sprite.position = pointForColumn(column, row:row)
                    figuresLayer.addChild(sprite)
                    figure!.sprite = sprite
                }
            }
        }
    }
    func addTiles() {
        for row in 0..<rowNumber {
            for column in 0..<colNumber {
                if let tile = gameBoard.tileAtColumn(column, row: row) {
                    let tileNode = SKSpriteNode(imageNamed: "Tile")
                    tileNode.name = "tile"
                    tileNode.anchorPoint = CGPointZero
                    tileNode.size = CGSize(width: TileWidth, height: TileHeight)
                    tileNode.position = pointForColumn(column, row: row)
                    tilesLayer.addChild(tileNode)
                }
            }
        }
    }
    
    func addFiguresForHand(hand: [Figure?]){
        for index in 0..<hand.count{
            let figure = hand[index]
            if figure != nil{
                let sprite = SKSpriteNode(imageNamed: figure!.toString)
                sprite.name = "figure"
                sprite.anchorPoint = CGPointZero
                sprite.size = CGSize(width: TileWidth, height: TileHeight)
                sprite.position = pointForHand(index)
                handLayer.addChild(sprite)
                
                figure!.sprite = sprite
            }
        }
    }
    
    func addTilesForHand(){
        for index in 0..<handNumber{
            
            let tileNode = SKSpriteNode(imageNamed: "Tile")
            tileNode.name = "tile"
            tileNode.anchorPoint = CGPointZero
            tileNode.position = CGPoint(x: CGFloat(index)*TileWidth, y: 0)
            tileNode.size = CGSize(width: TileWidth+2, height: TileHeight+2)
            handTilesLayer.addChild(tileNode)
        }
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth,
            y: CGFloat(row)*TileHeight)
    }
    
    func pointForHand(column: Int) -> CGPoint{
        return CGPoint(
            x: CGFloat(column)*TileWidth,
            y: 0)
    }
    
    func isPlaceAtGameBoardEmpty(column: Int, row: Int) -> Bool{
        if gameBoard.figureAtColumn(column, row: row) == nil && gameBoard.currentMoveFiguresArray[column, row] == nil{
            return true
        }
        return false
    }
    
    func isPlaceAtHandEmpty(column: Int) -> Bool{
        if gameBoard.hand[column] == nil{
            return true
        }
        return false
    }
    
    func coordinateForPointInGameBoard(point: CGPoint) -> (column: Int, row: Int, isInGameBoard: Bool){
        let x = point.x
        let y = point.y
        let column: Int = Int(x / TileWidth)
        let row: Int = Int(y / TileHeight)
        
        if column >= 0 && row >= 0 && column < colNumber && row < rowNumber && x >= 0 && y >= 0{
            return (column, row, true)
        }
        return (column, row, false)
    }
    
    func columnForPointInHand(point: CGPoint) ->(column: Int, isInHand: Bool){
        let x = point.x
        let y = point.y
        let column: Int = Int(x / TileWidth)
        let row: Int = Int(y / TileHeight)
        if column >= 0 && column <= 6 && x >= 0 && y >= 0 && row == 0{
            return (column, true)
        }
        return (column, false)
    }
    
    func isFigureFromCurrentMove(column: Int, row: Int) -> Bool{
        if gameBoard.currentMoveFiguresArray[column, row] != nil{
            return true
        }
        return false
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches {
            let touch = touch as! UITouch
            let positionInScene = touch.locationInNode(self)
            let positionInGameBoard = touch.locationInNode(figuresLayer)
            let positionInHand = touch.locationInNode(handLayer)
            
            selectNodeForTouch(positionInScene, gameboardLocation: positionInGameBoard, handLocation: positionInHand)
        }
    }
    func selectNodeForTouch(touchLocation: CGPoint, gameboardLocation: CGPoint, handLocation: CGPoint) {
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if touchedNode is SKSpriteNode {
            if let name = touchedNode.name{
                if touchedNode.name! == "figure" {
                    let coordinate = coordinateForPointInGameBoard(gameboardLocation)
                    if coordinate.isInGameBoard && isFigureFromCurrentMove(coordinate.column, row: coordinate.row){
                        self.isFromGameBoard = true
                        self.isFromHand = false
                        movementEnable = true
                        selectedNode = (touchedNode as! SKSpriteNode)
                        selectedNode!.removeAllActions()
                        
                        startedPosition = selectedNode!.position
                        let liftUp = SKAction.scaleTo(1.5, duration: 0.2)
                        selectedNode!.runAction(liftUp, withKey: "pickup")
                        //DO STUFF
                        
                    }
                    else{
                        let coordinateHand = columnForPointInHand(handLocation)
                        if coordinateHand.isInHand{
                            self.isFromHand = true
                            self.isFromGameBoard = false
                            movementEnable = true
                            selectedNode = (touchedNode as! SKSpriteNode)
                            selectedNode!.removeAllActions()
                            
                            startedPosition = selectedNode!.position
                            let liftUp = SKAction.scaleTo(1.5, duration: 0.2)
                            selectedNode!.runAction(liftUp, withKey: "pickup")
                            //DO STUFF
                        }
                    }

                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if movementEnable{
            for touch in touches {
                let touch = touch as! UITouch
                
                let locationInGameBoard = touch.locationInNode(figuresLayer)
                let coordinate = coordinateForPointInGameBoard(locationInGameBoard)
                //DROP ON GAMEBOARD
                if coordinate.isInGameBoard{
                    //PLACE IS EMPTY
                    if isPlaceAtGameBoardEmpty(coordinate.column, row: coordinate.row){
                        //Figure from gameboard
                        if isFromGameBoard{
                            let figureToRemovePosition = coordinateForPointInGameBoard(startedPosition!)
                            selectedFigure = gameBoard.currentMoveFiguresArray[figureToRemovePosition.column, figureToRemovePosition.row]
                            gameBoard.currentMoveFiguresArray[coordinate.column, coordinate.row] = selectedFigure
                            gameBoard.currentMoveFiguresArray[figureToRemovePosition.column, figureToRemovePosition.row] = nil
                        }
                            //figure from hand
                        else{
                            let figureToRemovePosition = columnForPointInHand(startedPosition!)
                            selectedFigure = gameBoard.hand[figureToRemovePosition.column]
                            
                            gameBoard.currentMoveFiguresArray[coordinate.column, coordinate.row] = selectedFigure
                            gameBoard.hand[figureToRemovePosition.column] = nil
                        }
                        selectedNode!.removeFromParent()
                        figuresLayer.addChild(selectedNode!)
                        selectedNode!.position = pointForColumn(coordinate.column, row: coordinate.row)
                    }
                        //FIGURE
                    else{
                        selectedNode!.position = startedPosition!
                    }
                }
                else{
                    let coordinateInHand = columnForPointInHand(touch.locationInNode(handLayer))
                    //DROP ON HAND LAYER
                    if coordinateInHand.isInHand{
                        if isPlaceAtHandEmpty(coordinateInHand.column){
                            if isFromHand{
                                let figureToRemovePosition = columnForPointInHand(startedPosition!)
                                selectedFigure = gameBoard.hand[figureToRemovePosition.column]
                                gameBoard.hand[coordinateInHand.column] = selectedFigure
                                gameBoard.hand[figureToRemovePosition.column] = nil
                                
                                selectedNode!.removeFromParent()
                                handLayer.addChild(selectedNode!)
                                selectedNode!.position = pointForHand(coordinateInHand.column)
                            }
                            else if isFromGameBoard{
                                let figureToRemovePosition = coordinateForPointInGameBoard(startedPosition!)
                                selectedFigure = gameBoard.currentMoveFiguresArray[figureToRemovePosition.column, figureToRemovePosition.row]
                                gameBoard.hand[coordinateInHand.column] = selectedFigure
                                gameBoard.currentMoveFiguresArray[figureToRemovePosition.column, figureToRemovePosition.row] = nil
                                
                                selectedNode!.removeFromParent()
                                handLayer.addChild(selectedNode!)
                                selectedNode!.position = pointForHand(coordinateInHand.column)
                            }
                        }
                        else{
                            selectedNode!.position = startedPosition!
                        }
                    }
                        //DROP ELSEWHERE
                    else{
                        selectedNode!.position = startedPosition!
                    }
                }
                selectedNode!.zPosition = 0
                
                let dropDown = SKAction.scaleTo(1.0, duration: 0.2)
                selectedNode!.runAction(dropDown, withKey: "drop")
                selectedNode = nil
                movementEnable = false
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if movementEnable{
            for touch in touches {
                let touch = touch as! UITouch
                let positionInScene = touch.locationInNode(self)
                let touchedNode = nodeAtPoint(positionInScene)
                if let name = touchedNode.name{
                    if name == "figure"{
                        let previousPosition = touch.previousLocationInNode(self)
                        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
                        
                        panForTranslation(translation)
                    }
                }
            }
        }
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode!.position
        
        if let name = selectedNode!.name {
            if  name == "figure"{
                selectedNode!.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
                selectedNode?.zPosition = 1
            }
        }
    }
    
    func redrawBoard(){
        figuresLayer.removeAllChildren()
        handLayer.removeAllChildren()
    }
    
    func commitMove(){
        addFiguresToGeneralArray()
        gameBoard.moveHandFiguresToRight()
        gameBoard.takeFiguresToHand()
    }
    
    func addFiguresToGeneralArray(){
        for row in 0..<rowNumber {
            for column in 0..<colNumber {
                let figure = gameBoard.currentMoveFiguresArray[column, row]
                if figure != nil{
                    gameBoard.setFigureAtColumn(column, row: row, figure: figure)
                }
            }
        }
        gameBoard.clearCurrentMoveArray()
    }
}