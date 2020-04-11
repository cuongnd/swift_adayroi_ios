//
//  ProductCollectionViewCell.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Kingfisher
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    
    func configureCell(category: Category) {
        categoryLabel.text = category.name
    }
    
   
}

