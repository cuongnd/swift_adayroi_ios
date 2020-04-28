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
    weak var delegate: CartTableViewController?
    @IBOutlet weak var UIStepperUpDownTotalProduct: UIStepper!
    @IBOutlet weak var UIButtonDeleteProduct: UIButton!
    func configureCell(item: ShoppingCartItem?) {
        guard let item = item else {
            return
        }
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
        print("hello setup")
        UIButtonDeleteProduct.addTarget(self, action: #selector(handlePlaceOrderButton), for: .touchUpInside)
    }
    @objc
    fileprivate func handlePlaceOrderButton() {
        print("hello delete")
        delegate?.delete_product_in_cart(UIButtonDeleteProduct)
    }
}
