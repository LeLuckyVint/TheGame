//
//  SignUpViewController.swift
//  Muzzle
//
//  Created by Vitaly on 19.07.15.
//  Copyright (c) 2015 BorisTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController, UITextFieldDelegate {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.emailField.delegate = self
        
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 0x21, green: 0x21, blue: 0x21, alpha: 0.6)])
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 0x21, green: 0x21, blue: 0x21, alpha: 0.6)])
        emailField.attributedPlaceholder = NSAttributedString(string:"E-mail",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 0x21, green: 0x21, blue: 0x21, alpha: 0.6)])
        
        var tap = UITapGestureRecognizer(target: self, action: "dissmissKeyboard")
        self.view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dissmissKeyboard(){
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
    }
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var alreadyRegisteredButton: UIButton!
    
    @IBAction func backToLogin(sender: UIButton) {
        
    }
    @IBAction func register(sender: UIButton) {
        ServerCommunicator.register(usernameField.text, password: passwordField.text, email: emailField.text)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textView: UITextField) {
        let myScreenRect: CGRect = UIScreen.mainScreen().bounds
        let keyboardHeight : CGFloat = 216
        
        UIView.beginAnimations("animateView", context: nil)
        var movementDuration:NSTimeInterval = 0.35
        var needToMove: CGFloat = 0
        
        var frame : CGRect = self.view.frame
        if (textView.frame.origin.y + textView.frame.size.height + UIApplication.sharedApplication().statusBarFrame.size.height > (myScreenRect.size.height - keyboardHeight)) {
            needToMove = (textView.frame.origin.y + textView.frame.size.height + UIApplication.sharedApplication().statusBarFrame.size.height) - (myScreenRect.size.height - keyboardHeight);
        }
        frame.origin.y = -needToMove
        self.view.frame = frame
        self.view.superview?.backgroundColor = self.view.backgroundColor
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(textView: UITextField) {
        UIView.beginAnimations( "animateView", context: nil)
        var movementDuration:NSTimeInterval = 0.35
        var frame : CGRect = self.view.frame
        frame.origin.y = 0
        self.view.frame = frame
        UIView.commitAnimations()
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
