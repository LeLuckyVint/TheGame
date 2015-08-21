//
//  SendInviteTableViewController.swift
//  The Game
//
//  Created by demo on 20.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class SendInviteTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var results: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) as! SearchTableViewCell
        
        cell.usernameLabel.text = results[indexPath.row].username
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ServerCommunicator.sendInviteToUserWithId(results[indexPath.row].id)
        self.parentViewController!.dismissViewControllerAnimated(true, completion: nil)
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let text = searchBar.text
        ServerCommunicator.searchUsers(text){
            users, success in
            if success{
                self.results = users
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    
}
