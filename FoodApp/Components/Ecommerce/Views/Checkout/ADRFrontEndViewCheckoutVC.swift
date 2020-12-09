//
//  AddtoCartVC.swift
//  FoodApp
//
//  Created by Mitesh's MAC on 04/06/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite
import ETBinding
import SlideMenuControllerSwift


class ADRFrontEndViewCheckoutVC: UIViewController {
    
    @IBOutlet weak var UITextFieldShippingFullName: UITextField!
    @IBOutlet weak var UITextFieldShippingEmail: UITextField!
    @IBOutlet weak var UITextFieldShippingPhonenumber: UITextField!
    @IBOutlet weak var UITextViewShippingAddress1: UITextView!
    @IBOutlet weak var UITextViewShippingAddress2: UITextView!
    @IBOutlet weak var UISwitchSameShipping: UISwitch!
    
    
    @IBOutlet weak var UITextFieldPaymentFullName: UITextField!
    @IBOutlet weak var UITextFieldPaymentEmail: UITextField!
    @IBOutlet weak var UITextFieldPaymentPhoneNumber: UITextField!
    @IBOutlet weak var UITextViewPaymentAddress1: UITextView!
    @IBOutlet weak var UITextViewPaymentAddress2: UITextView!
    @IBOutlet weak var UITextViewNote: UITextView!
    @IBOutlet weak var UIButtonNext: UIButton!
    @IBOutlet weak var UIButtonBack: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
