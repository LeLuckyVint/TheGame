//
//  InviteViewController.swift
//  The Game
//
//  Created by demo on 04.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Alamofire

class InviteViewController: UIViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    var typeOfGame : GameType!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendInvite(sender: UIButton) {
        ServerCommunicator.sendInviteToUserWithId(userIdTextField.text!.toInt()!)
    }
}
