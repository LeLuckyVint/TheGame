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

class LoginViewController: ResponsiveTextFieldViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let jsonParser = JSONParser.sharedInstance
    var defaultDelegate: TextFieldDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultDelegate = TextFieldDelegate(vc: self)
        self.usernameField.delegate = defaultDelegate
        self.passwordField.delegate = defaultDelegate
        
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 0x21, green: 0x21, blue: 0x21, alpha: 0.6)])
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 0x21, green: 0x21, blue: 0x21, alpha: 0.6)])
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
