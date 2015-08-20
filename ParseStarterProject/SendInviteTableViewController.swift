//
//  SendInviteTableViewController.swift
//  The Game
//
//  Created by demo on 20.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class SendInviteTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
