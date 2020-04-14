//
//  ProductCollectionViewCell.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Kingfisher
import UIKit

class CategoryCollectionViewCell: ECCollectionViewCell {
    
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    
    func configureCell(category: Category) {
        var urlString = category.imageURL!
        categoryLabel.text = category.name
        if (!urlString.isEmpty) {
            urlString="http://shopper1.softway.vn/uploads/"+urlString
            let imageURL = URL(string: urlString)
            categoryImageView.kf.setImage(with: imageURL)
        }
    }
    func configureCell1(category: Category) {
        
    }
    
   
}

