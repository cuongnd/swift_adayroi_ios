//
//  CartTotalTableViewCell.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/28/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

class CartTotalTableViewCell: ECTableViewCell {

    @IBOutlet var totalPriceLabel: UILabel!

    func configureCell(total: Double) {
        let price_format = total as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "vi_VN") // This is the default
        // In Swift 4, this ^ has been renamed to simply NSLocale.current
        totalPriceLabel.text = formatter.string(from: price_format)
    }
}
