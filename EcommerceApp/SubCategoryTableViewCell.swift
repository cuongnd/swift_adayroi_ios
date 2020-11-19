//
//  CartTableViewCell.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/26/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: ECTableViewCell {

    @IBOutlet var subCategoryLabel: UILabel!
    
    func configureCell(sub_category: SubCategory) {
        subCategoryLabel.text = sub_category.name
    }
    
}