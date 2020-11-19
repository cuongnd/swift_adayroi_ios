//
//  Product.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//
import UIKit
class Order {
    
    var _id: String
    var total: Double?
    var order_number: String?
    
    init(_id: String,order_number:String,total:Double) {
        self._id = _id
        self.order_number = order_number
        self.total = total
    }
    

}

