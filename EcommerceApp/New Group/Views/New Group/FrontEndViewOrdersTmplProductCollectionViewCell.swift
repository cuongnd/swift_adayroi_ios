//
//  ProductCollectionViewCell.swift
//  EcommerceApp
//
//  Created by Macbook on 4/30/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class FrontEndViewOrdersTmplProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UILabelProductName: UILabel!
    @IBOutlet weak var UILabelProductPrice: UILabel!
    @IBOutlet weak var UILabelTotalProduct: UILabel!
    @IBOutlet weak var UILabelTotalPrice: UILabel!
    func configureCell(total:Double,product: Product) {
        UILabelProductName.text=product.productName
        
        
        let price_format = product.productPrice! as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "vi_VN") // This is the default
        // In Swift 4, this ^ has been renamed to simply NSLocale.current
        UILabelProductPrice.text = formatter.string(from: price_format)
        
        let price_format_total = total as NSNumber
        let formatter1 = NumberFormatter()
        formatter1.numberStyle = .currency
        formatter1.locale = Locale(identifier: "vi_VN") // This is the default
        // In Swift 4, this ^ has been renamed to simply NSLocale.current
        UILabelTotalPrice.text = formatter1.string(from: price_format_total)
        
        
        UILabelProductName.text=product.productName
    }
}
