//
//  UITextFieldFrontendCustomTextField.swift
//  EcommerceApp
//
//  Created by Macbook on 5/6/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit
@IBDesignable
class UITextFieldFrontendCustomTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var _cornerRadius: CGFloat = 0.0
    
    override var cornerRadius: CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            layer.cornerRadius = _cornerRadius
        } get {
            return _cornerRadius
        }
    }
}
