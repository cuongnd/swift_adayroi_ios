//
//  Product.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//
import UIKit
class Image {

    var id: String
    var name: String?
    var imageURL: String?

    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageURL = imageUrl
    }
}
