//
//  GameViewController.swift
//  The Game
//
//  Created by demo on 06.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var commitMoveButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var scene: GameScene!
    var gameBoard: GameBoard!
    var game: Game!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Present the scene.
        skView.presentScene(scene)
        gameBoard = GameBoard()
        gameBoard.figuresArray = game.figures
        gameBoard.hand = game.hand
        
        scene.gameBoard = gameBoard
        scene.addTiles()
        
        scene.addSpritesForFigures(gameBoard.figuresArray)
        
        if game.currentPlayerId == User.currentUser?.id{
            scene.addFiguresForHand(gameBoard.hand)
            scene.addTilesForHand()
        }
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func redrawBoard(sender: UIButton) {
        ServerCommunicator.getInfoAboutPuzzleGame(game.gameId){
            success, game in
            self.game = game
            if game?.currentPlayerId == User.currentUser?.id{
                self.gameBoard.figuresArray = self.game.figures
                self.gameBoard.hand = self.game.hand
                
                self.scene.redrawBoard()
                self.scene.addSpritesForFigures(self.gameBoard.figuresArray)
                self.scene.addFiguresForHand(self.gameBoard.hand)
                self.scene.addTilesForHand()
            }
        }
        
    }
    
    @IBAction func commitMove(sender: UIButton) {
        if game?.currentPlayerId == User.currentUser?.id{
            
            //scene.commitMove()
            ServerCommunicator.commitMove(gameBoard.currentMoveFiguresArray, gameId: game.gameId){
                success in
                if success{
                    self.scene.commitMove()
                    self.scene.clearHandLayer()
                }
            }
        }
    }
    
}
