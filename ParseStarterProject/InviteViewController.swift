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
        let token = NSUserDefaults.standardUserDefaults().stringForKey("token")
        println(typeOfGame.getStringForJSON())
        println(token)
        ServerCommunicator.sendInviteToUserWithId(userIdTextField.text!.toInt()!, token: token!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
