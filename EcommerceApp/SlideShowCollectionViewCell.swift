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
    
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var slideshowLabel: UILabel!
    
    func configureCell(category: Category) {
        slideshowLabel.text = category.name
        if let urlString = category.imageURL {
            let imageURL = URL(string: urlString)
            categoryImageView.kf.setImage(with: imageURL)
        }
    }
    func configureCell1(category: Category) {
        
    }
    
    
}


