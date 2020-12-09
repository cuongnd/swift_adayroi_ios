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

import SlideMenuControllerSwift


class ADRFrontEndViewCheckoutVC: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var UITextFieldShippingFullName: UITextField!
    @IBOutlet weak var UITextFieldShippingEmail: UITextField!
    @IBOutlet weak var UITextFieldShippingPhonenumber: UITextField!
    @IBOutlet weak var UITextViewShippingAddress1: UITextView!
    @IBOutlet weak var UITextViewShippingAddress2: UITextView!
    @IBOutlet weak var UISwitchSameShipping: UISwitch!
    
    
    @IBOutlet weak var UITextFieldBillingFullName: UITextField!
    @IBOutlet weak var UITextFieldBillingEmail: UITextField!
    @IBOutlet weak var UITextFieldBillingPhone: UITextField!
    @IBOutlet weak var UITextViewBillingAddress1: UITextView!
    @IBOutlet weak var UITextViewBillingAddress2: UITextView!
    @IBOutlet weak var UITextViewNote: UITextView!
    @IBOutlet weak var UIButtonNext: UIButton!
    @IBOutlet weak var UIButtonBack: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextViewShippingAddress1.delegate = self
        UITextViewShippingAddress2.delegate = self

        
    }
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        if(textView==self.UITextViewShippingAddress1 && UISwitchSameShipping.isOn){
            UITextViewBillingAddress1.text=textView.text
        }else if(textView==self.UITextViewShippingAddress2 && UISwitchSameShipping.isOn){
            UITextViewBillingAddress2.text=textView.text
        }
    }
    @IBAction func UITextFieldShippingFullNameChange(_ sender: UITextField) {
        if(UISwitchSameShipping.isOn){
            UITextFieldBillingFullName.text=sender.text
        }
    }
    @IBAction func UITextFieldShippingEmailChange(_ sender: UITextField) {
        if(UISwitchSameShipping.isOn){
            UITextFieldBillingEmail.text=sender.text
        }
    }
    @IBAction func UITextFieldShippingPhoneNUmberChange(_ sender: UITextField) {
        if(UISwitchSameShipping.isOn){
            UITextFieldBillingPhone.text=sender.text
        }
    }
    
    @IBAction func UISwitchValueChange(_ sender: UISwitch) {
        UITextFieldBillingFullName.isEnabled = !sender.isOn
        UITextFieldBillingEmail.isEnabled = !sender.isOn
        UITextFieldBillingPhone.isEnabled = !sender.isOn
        UITextViewBillingAddress1.isEditable = !sender.isOn
        UITextViewBillingAddress2.isEditable = !sender.isOn
        if(sender.isOn){
            UITextFieldBillingFullName.text=UITextFieldShippingFullName.text
            UITextFieldBillingEmail.text=UITextFieldShippingEmail.text
            UITextFieldBillingPhone.text=UITextFieldShippingPhonenumber.text
            UITextViewBillingAddress1.text=UITextViewShippingAddress1.text
            UITextViewBillingAddress2.text=UITextViewShippingAddress2.text
            
        }
    }
    
   
    
    
    @IBAction func go_to_sumary_checkout(_ sender: UIButton) {
        if(UITextFieldShippingFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            UITextFieldShippingFullName.text="";
            UITextFieldShippingFullName.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ và tên người nhận hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if(UITextFieldShippingEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            UITextFieldShippingEmail.text="";
            UITextFieldShippingEmail.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập email người nhận hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if(!LibraryUtilitiesUtility.isValidEmail(UITextFieldShippingEmail.text!)){
            UITextFieldShippingEmail.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đúng định dạng email người nhận hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        if(UITextFieldShippingPhonenumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            UITextFieldShippingPhonenumber.text="";
            UITextFieldShippingPhonenumber.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại người nhận hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        if(UITextViewShippingAddress1.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            UITextViewShippingAddress1.text="";
            UITextViewShippingAddress1.becomeFirstResponder()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập địa chỉ người nhận hàng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if(!UISwitchSameShipping.isOn){
            
            if(UITextFieldBillingFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextFieldBillingFullName.text="";
                UITextFieldBillingFullName.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ và tên người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            if(UITextFieldBillingEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextFieldBillingEmail.text="";
                UITextFieldBillingEmail.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập email người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            if(!LibraryUtilitiesUtility.isValidEmail(UITextFieldBillingEmail.text!)){
                UITextFieldBillingEmail.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đúng định dạng email người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            if(UITextFieldBillingPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextFieldBillingPhone.text="";
                UITextFieldBillingPhone.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            if(UITextViewBillingAddress1.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextViewBillingAddress1.text="";
                UITextViewBillingAddress1.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập địa chỉ người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
        }
      
        
        let user_id:String=UserDefaultManager.getStringFromUserDefaults(key: UD_userId)
            
        let params: NSDictionary = [
        "shipping_fullname": UITextFieldShippingFullName.text!,
        "shipping_email": UITextFieldShippingEmail.text!,
        "shipping_phonenumber": UITextFieldShippingPhonenumber.text!,
        "shipping_address1": UITextViewShippingAddress1.text!,
        "shipping_address2": UITextViewShippingAddress2.text!,
        
        "billing_fullname": UITextFieldBillingFullName.text!,
        "billing_email": UITextFieldBillingEmail.text!,
        "billing_phone": UITextFieldBillingPhone.text!,
        "billing_addrress1": UITextViewBillingAddress1.text!,
        "billing_addrress2": UITextViewBillingAddress2.text!,
        
        ]
        let urlStringPostUpdateUser = API_URL + "/api_task/users.update_user_info?user_id=\(user_id)"
        self.Webservice_getUpdateUser(url: urlStringPostUpdateUser, params: params)
        
        
        //let sumaryCheckoutViewControllerVC = StoryboardEntityProvider().SumaryCheckoutViewControllerVC()
        //sumaryCheckoutViewControllerVC.jsonAddressShippingAndPayment=jsonAddressShippingAndPayment
        //self.navigationController?.pushViewController(sumaryCheckoutViewControllerVC, animated: true)
    }
    
}
extension ADRFrontEndViewCheckoutVC
{
    func Webservice_getUpdateUser(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                     let data = jsonResponse!["data"].dictionaryValue
                     
                    
                    
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    
    
}

