//
//  ProductCollectionViewCell.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Kingfisher
import UIKit

class SlideShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    
    func configureCell(product: Product) {
        productTitleLabel.text = product.productName
        productPriceLabel.text=String(format:"%.1f", product.productPrice!)
        if let url = product.productImageURL, let productImageView = productImageView {
            productImageView.kf.setImage(with: URL(string: url))
        }
    }
    
}

