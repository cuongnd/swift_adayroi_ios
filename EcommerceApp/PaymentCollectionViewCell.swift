//
//  ProductCollectionViewCell.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Kingfisher
import UIKit

class PaymentCollectionViewCell: ECCollectionViewCell {
    
   
    
    @IBOutlet weak var UILabelPayment: UILabel!
    @IBOutlet weak var UIImageViewPayment: UIImageView!
    func configureCell(payment: Payment) {
        let urlString = payment.imageURL!
        UILabelPayment.text = payment.name
        if (!urlString.isEmpty) {
            let imageURL = URL(string: urlString)
            UIImageViewPayment.kf.setImage(with: imageURL)
        }
    }
    
    
   
}

