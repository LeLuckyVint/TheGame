//
//  TextFieldDelegate.swift
//  The Game
//
//  Created by demo on 20.08.15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    var vc: ResponsiveTextFieldViewController
    
    init(vc: ResponsiveTextFieldViewController){
        self.vc = vc
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        vc.activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        vc.activeField = nil
    }
}