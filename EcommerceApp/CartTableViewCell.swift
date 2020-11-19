//
//  CartTableViewCell.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/26/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

class CartTableViewCell: ECTableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var UIButtonDeleteProductInCart: UIButton!
    weak var delegate: CartTableViewController?
    @IBOutlet weak var UIStepperUpDownTotalProduct: UIStepper!
    @IBOutlet weak var UITextFieldQuanlity: UITextField!
    var item: ShoppingCartItem?
    func configureCell(item: ShoppingCartItem?) {
        
        guard let item = item else {
            return
        }
        self.item=item
        self.isUserInteractionEnabled = true
        if let url = item.product.productImageURL, let productImageView = productImageView {
            productImageView.kf.setImage(with: URL(string: url))
        }
        if let price = item.product.productPrice {
            let price_format = price * Double(item.quantity) as NSNumber
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "vi_VN") // This is the default
            // In Swift 4, this ^ has been renamed to simply NSLocale.current
            productPriceLabel.text = formatter.string(from: price_format)
        }
        if let productName = item.product.productName {
            let name = (item.quantity > 1) ? productName + " x \(item.quantity)" : productName
            productNameLabel.text = name
        }
        
        UIButtonDeleteProductInCart?.addTarget(self, action: #selector(handleDeleteProductButton), for: .touchUpInside)
        UITextFieldQuanlity.text=String(item.quantity)
        UIStepperUpDownTotalProduct.autorepeat = true
        UIStepperUpDownTotalProduct.minimumValue = 1
        UIStepperUpDownTotalProduct.maximumValue = 10
        UIStepperUpDownTotalProduct.value=Double(item.quantity)
        UIStepperUpDownTotalProduct.addTarget(self, action: #selector(stepperValueChanged(stepper:)), for: .valueChanged)

     
    }
    func stepperValueChanged(stepper: UIStepper) {
        if (Double((item?.quantity)!)<stepper.value)
        {
           delegate?.update_quanlity_product_in_cart(product: (item?.product)!,quanlity:1)
        }
        else
        {
           delegate?.update_quanlity_product_in_cart(product: (item?.product)!,quanlity:-1)
        }
        
    }
    @objc
    fileprivate func handleDeleteProductButton() {
     delegate?.delete_product_in_cart(sender: UIButtonDeleteProductInCart,item:self.item!)
    }
    
    
}
