//
//  ResponsiveTextFieldViewController.swift
//  The Game
//
//  Created by demo on 20.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//
import Foundation
import UIKit

class ResponsiveTextFieldViewController : UIViewController
{
    weak var activeField: UITextField?
    var wasMoved = false
    var isKeyboardOnScreen = false
    var height: CGFloat!
    var moveDistance: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    func keyboardWasShown(notification: NSNotification)
    {
        if !isKeyboardOnScreen{
            isKeyboardOnScreen = true
            var info : NSDictionary = notification.userInfo!
            var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
            
            var aRect : CGRect = self.view.frame
            aRect.size.height -= keyboardSize!.height + activeField!.bounds.height
            
            //height = self.view.bounds.maxY - activeField!.bounds.maxY
            height = activeField!.frame.origin.y + activeField!.bounds.height
            if let activeFieldPresent = activeField
            {
                if (!CGRectContainsPoint(aRect, activeField!.frame.origin))
                {
                    wasMoved = true
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.moveDistance = (self.height - self.view.frame.height + keyboardSize!.height)
                        self.view.frame.origin.y -= self.moveDistance
                    })
                }
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        isKeyboardOnScreen = false
        if wasMoved{
            self.view.frame.origin.y += moveDistance
        }
        wasMoved = false
    }
}

