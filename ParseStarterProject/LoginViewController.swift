//
//  LoginViewController.swift
//  Muzzle
//
//  Created by Vitaly on 19.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let jsonParser = JSONParser.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 0x21, green: 0x21, blue: 0x21, alpha: 0.6)])
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 0x21, green: 0x21, blue: 0x21, alpha: 0.6)])
        var tap = UITapGestureRecognizer(target: self, action: "dissmissKeyboard")
        
        self.view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dissmissKeyboard(){
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func login(sender: UIButton) {
        ServerCommunicator.login(usernameField.text, password: passwordField.text)
    }
    
    @IBAction func signUp(sender: UIButton) {
        
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
