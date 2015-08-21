//
//  GamesTableViewController.swift
//  The Game
//
//  Created by demo on 12.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController {

    let jsonParser = JSONParser.sharedInstance
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let games = [GameType.PUZZLE]
    var typeToPass: GameType!
    let reachability = Reachability.reachabilityForInternetConnection()
    override func viewDidLoad() {
        super.viewDidLoad()
        var backgroundView =  UIView(frame: CGRectZero)
        self.tableView.backgroundColor = Standart.purpleColor
        self.tableView.tableFooterView = backgroundView
        reachability.whenUnreachable = { reachability in
            Reachability.showAlert(self)
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath) as! GameTableViewCell
        
        cell.type = games[indexPath.row]
        cell.gameNameLabel.text = games[indexPath.row].rawValue
        cell.backgroundColor = games[indexPath.row].getColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if reachability.isReachable(){
            let selectedCell = tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath) as! GameTableViewCell
            typeToPass = games[indexPath.row]
            self.performSegueWithIdentifier("showFriends", sender: selectedCell)
        }
        else{
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! PlayersTableViewController
        controller.typeOfGame = typeToPass
    }
}
