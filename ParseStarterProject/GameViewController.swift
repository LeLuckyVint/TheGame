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
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var commitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var gameView: SKView!
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var yourAvatarImageView: UIImageView!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentAvatarImageView: UIImageView!
    @IBOutlet weak var whosTurnLabel: UILabel!
    var scene: GameScene!
    var gameBoard: GameBoard!
    var game: Game!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = Standart.purpleColor
        if self.revealViewController() != nil {
            self.revealViewController().rightViewController = nil
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        yourNameLabel.text = game.you.user.username
        yourScoreLabel.text = "\(game.you.score)"
        yourAvatarImageView.image = game.you.user.avatar
        opponentNameLabel.text = game.opponent.user.username
        opponentScoreLabel.text = "\(game.opponent.score)"
        opponentAvatarImageView.image = game.opponent.user.avatar
        cropAvatar(yourAvatarImageView)
        cropAvatar(opponentAvatarImageView)
        
        // Configure the view.
        //let skView = view as! SKView
        //skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: gameView.bounds.size)
        scene.game = game
        //scene.scaleMode = .AspectFit
        
        // Present the scene.
        gameView.presentScene(scene)
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
        skipButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        skipButton.setImage(UIImage(named: "propustit"), forState: UIControlState.Normal)
        
        commitButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        commitButton.setImage(UIImage(named: "galochka"), forState: UIControlState.Normal)
        
        cancelButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        cancelButton.setImage(UIImage(named: "krestik"), forState: UIControlState.Normal)
    }
    
    func cropAvatar(avatarImageView: UIImageView){
        avatarImageView.layer.borderWidth=1.0
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarImageView.layer.cornerRadius = 13
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
        avatarImageView.clipsToBounds = true
    }
    
    func layoutForButton(button: UIButton){
        // the space between the image and text
        var spacing: CGFloat = 6.0;
        
        // lower the text and push it left so it appears centered
        //  below the image
        let imageSize = button.imageView!.frame.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, spacing - imageSize.height, 0.0)
        
        // raise the image and push it right so it appears centered
        //  above the text
        let titleSize = button.titleLabel!.frame.size;
        button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
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
    
    @IBAction func skipMove(sender: UIButton) {
        if scene.changeMode{
            
        }
        else{
//            ServerCommunicator.getInfoAboutPuzzleGame(game.gameId){
//                success, game in
//                self.game = game
//                if game?.currentPlayerId == User.currentUser?.id{
//                    self.gameBoard.figuresArray = self.game.figures
//                    self.gameBoard.hand = self.game.hand
//                    
//                    self.scene.redrawBoard()
//                    self.scene.addSpritesForFigures(self.gameBoard.figuresArray)
//                    self.scene.addFiguresForHand(self.gameBoard.hand)
//                    self.scene.addTilesForHand()
//                }
//            }
        }
    }
    
    @IBAction func commitMove(sender: UIButton) {
        if scene.changeMode{
            ServerCommunicator.changeFiguresInHand(scene.gameBoard.changeArray, gameId: scene.game.gameId)
            scene.changeMode = false
            scene.tilesLayer.hidden = false
            scene.figuresLayer.hidden = false
            scene.gameBoard.changeArray = []
            scene.cancelChange()
        }
        else{
            if game?.currentPlayerId == User.currentUser?.id{
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
    
    @IBAction func changeFigures(sender: UIButton) {
        if scene.changeMode{
            scene.changeMode = false
            scene.tilesLayer.hidden = false
            scene.figuresLayer.hidden = false
            scene.gameBoard.changeArray = []
            scene.cancelChange()
        }
        else{
            scene.tilesLayer.hidden = true
            scene.figuresLayer.hidden = true
            scene.returnFiguresToHand()
            scene.redrawHand()
            scene.changeMode = true
        }
        
    }
}

