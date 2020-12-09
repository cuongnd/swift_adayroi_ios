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
        UITextViewShippingAddress1.delegate = self
        UITextViewShippingAddress2.delegate = self

        
    }
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        if(textView==self.UITextViewShippingAddress1 && UISwitchSameShipping.isOn){
            UITextViewPaymentAddress1.text=textView.text
        }else if(textView==self.UITextViewShippingAddress2 && UISwitchSameShipping.isOn){
            UITextViewPaymentAddress2.text=textView.text
        }
    }
    @IBAction func UITextFieldShippingFullNameChange(_ sender: UITextField) {
        if(UISwitchSameShipping.isOn){
            UITextFieldPaymentFullName.text=sender.text
        }
    }
    @IBAction func UITextFieldShippingEmailChange(_ sender: UITextField) {
        if(UISwitchSameShipping.isOn){
            UITextFieldPaymentEmail.text=sender.text
        }
    }
    @IBAction func UITextFieldShippingPhoneNUmberChange(_ sender: UITextField) {
        if(UISwitchSameShipping.isOn){
            UITextFieldPaymentPhoneNumber.text=sender.text
        }
    }
    
    @IBAction func UISwitchValueChange(_ sender: UISwitch) {
        UITextFieldPaymentFullName.isEnabled = !sender.isOn
        UITextFieldPaymentEmail.isEnabled = !sender.isOn
        UITextFieldPaymentPhoneNumber.isEnabled = !sender.isOn
        UITextViewPaymentAddress1.isEditable = !sender.isOn
        UITextViewPaymentAddress2.isEditable = !sender.isOn
        if(sender.isOn){
            UITextFieldPaymentFullName.text=UITextFieldShippingFullName.text
            UITextFieldPaymentEmail.text=UITextFieldShippingEmail.text
            UITextFieldPaymentPhoneNumber.text=UITextFieldShippingPhonenumber.text
            UITextViewPaymentAddress1.text=UITextViewShippingAddress1.text
            UITextViewPaymentAddress2.text=UITextViewShippingAddress2.text
            
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
            
            if(UITextFieldPaymentFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextFieldPaymentFullName.text="";
                UITextFieldPaymentFullName.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ và tên người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            if(UITextFieldPaymentEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextFieldPaymentEmail.text="";
                UITextFieldPaymentEmail.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập email người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            if(!LibraryUtilitiesUtility.isValidEmail(UITextFieldPaymentEmail.text!)){
                UITextFieldPaymentEmail.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đúng định dạng email người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            if(UITextFieldPaymentPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextFieldPaymentPhoneNumber.text="";
                UITextFieldPaymentPhoneNumber.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            if(UITextViewPaymentAddress1.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
                UITextViewPaymentAddress1.text="";
                UITextViewPaymentAddress1.becomeFirstResponder()
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập địa chỉ người thanh toán", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
        }
      
        
        
            
        let params: NSDictionary = [
        "shipping_fullname": UITextFieldShippingFullName.text!,
        "shipping_email": UITextFieldShippingEmail.text!,
        "shipping_phonenumber": UITextFieldShippingPhonenumber.text!,
        "shipping_address1": UITextViewShippingAddress1.text!,
        "shipping_address2": UITextViewShippingAddress2.text!,
        
        "biding_fullname": UITextFieldPaymentFullName.text!,
        "Payment_email": UITextFieldPaymentEmail.text!,
        "Payment_phonenumber": UITextFieldPaymentPhoneNumber.text!,
        "Payment_addrress1": UITextViewPaymentAddress1.text!,
        "Payment_addrress2": UITextViewPaymentAddress2.text!,
        
        ]
        let urlStringPostUpdateUser = API_URL + "/api_task/users.update_user_info"
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

