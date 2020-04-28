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
            productPriceLabel.text = String(format:"$%.2f", price * Double(item.quantity))
        }
        if let productName = item.product.productName {
            let name = (item.quantity > 1) ? productName + " x \(item.quantity)" : productName
            productNameLabel.text = name
        }
        
        UIButtonDeleteProductInCart?.addTarget(self, action: #selector(handleDeleteProductButton), for: .touchUpInside)
        
        UIStepperUpDownTotalProduct.autorepeat = true
        UIStepperUpDownTotalProduct.minimumValue = 1
        UIStepperUpDownTotalProduct.maximumValue = 10
        UIStepperUpDownTotalProduct.value=Double(item.quantity)
        UIStepperUpDownTotalProduct.addTarget(self, action: #selector(stepperValueChanged(stepper:)), for: .valueChanged)

     
    }
    func stepperValueChanged(stepper: UIStepper) {
        
        print(stepper.value)
        
    }
    @objc
    fileprivate func handleDeleteProductButton() {
     delegate?.delete_product_in_cart(sender: UIButtonDeleteProductInCart,item:self.item!)
    }
    
    
}
