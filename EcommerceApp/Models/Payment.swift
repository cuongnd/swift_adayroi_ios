//
//  Product.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//
import UIKit
class Payment {

    var id: String
    var name: String?
    var imageURL: String?
    var payment_type: String?

    init(id: String, name: String, imageUrl: String,payment_type:String) {
        self.id = id
        self.name = name
        self.imageURL = imageUrl
        self.payment_type = payment_type
    }
}
