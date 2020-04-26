//
//  ProductDetailsViewController.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/22/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Material
import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"


class AddressCheckoutViewController: UIViewController, UITextViewDelegate {
    var product: Product? {
        didSet {
            
            self.title = product?.productName
            
            
            self.view.setNeedsLayout()
        }
    }
     var bodyContentHeight:CGFloat = 0.0
    var heightConstraint: NSLayoutConstraint!
    var images=[Image]();
    var product_id:String=""
    var full_description:String=""
    
    @IBOutlet weak var UITextFieldBidingFullName: UITextField!
    
    @IBAction func UITextFieldFullName(_ sender: UITextField) {
        if(UISwitchIsShiping.isOn)
        {
            UITextFieldBidingFullName.text=sender.text
        }
    }
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        if(textView.tag==0 && UISwitchIsShiping.isOn){
            UITextViewBindingAddrress1.text=textView.text
        }
        if(textView.tag==1 && UISwitchIsShiping.isOn){
            UITextViewBindingAddrress2.text=textView.text
        }
    }
    
    @IBOutlet weak var UITextViewShippingAddress2: UITextView!
    @IBOutlet weak var UITextViewShippingAddress1: UITextView!
    @IBOutlet weak var UITextFieldShippingPhoneNumber: UITextField!
    @IBOutlet weak var UITextViewBindingAddrress2: UITextView!
    @IBOutlet weak var UITextViewBindingAddrress1: UITextView!
    @IBOutlet weak var UITextFieldPhoneNumber: UITextField!
    @IBOutlet weak var UITextFieldBindingEmail: UITextField!
    @IBOutlet weak var UISwitchIsShiping: UISwitch!
    @IBAction func go_to_back_product_detail(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var UITextViewShippingAdress1: UITextView!
    @IBAction func UISwitchValueChange(_ sender: UISwitch) {
        UITextFieldBidingFullName.isEnabled = !sender.isOn
        UITextFieldBindingEmail.isEnabled = !sender.isOn
        UITextFieldPhoneNumber.isEnabled = !sender.isOn
        UITextViewBindingAddrress1.isEditable = !sender.isOn
        UITextViewBindingAddrress2.isEditable = !sender.isOn
        
    }
    @IBOutlet weak var UITextFieldBindingPhoneNumber: UITextField!
    @IBAction func UITextFieldShippingPhoneNumberEditingChanged(_ sender: UITextField) {
        if(UISwitchIsShiping.isOn)
        {
            UITextFieldBindingPhoneNumber.text=sender.text
        }
    }
    @IBOutlet weak var UITextFieldShippingEmail: UITextField!
    @IBAction func UITextFieldShippingEmailEditingChanged(_ sender: UITextField) {
        if(UISwitchIsShiping.isOn)
        {
            UITextFieldBindingEmail.text=sender.text
        }
    }
    @IBAction func go_to_sumary_checkout(_ sender: UIButton) {
        let sumaryCheckoutViewControllerVC = StoryboardEntityProvider().SumaryCheckoutViewControllerVC()
        self.navigationController?.pushViewController(sumaryCheckoutViewControllerVC, animated: true)
    }
    @IBAction func add_to_cart(_ sender: Any) {
    }
    @IBOutlet weak var footerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       //updateContentViewHeight()
        UITextViewShippingAddress1.delegate = self
        UITextViewShippingAddress2.delegate = self
    }
   
  
    @IBAction func show_full_description_product(_ sender: UIButton) {
        let Product_Details_Full_Description_View_VC = StoryboardEntityProvider().Product_Details_Full_Description_View_VC()
        Product_Details_Full_Description_View_VC.full_description_product=self.full_description
        self.navigationController?.pushViewController(Product_Details_Full_Description_View_VC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(product?.id ?? "nothing")
        //self.detailsTextView.text = product?.productDescription

       
        //updateContentViewHeight()
    }
    
    
    @objc
    fileprivate func didTapShowFullDescriptionButton() {
        
    }
    @objc
    fileprivate func didTapAddToCartButton() {
        NotificationCenter.default.post(name: kNotificationDidAddProductToCart, object: nil, userInfo: ["product": product ?? nil])
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddressCheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        print("image123")
        print(self.images[indexPath.row].imageURL!)
        cell.configureCell(imageUrl: self.images[indexPath.row].imageURL!)
        return cell
    }

   
}

