//
//  ObjectMapperFrontendCart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct OrderAttributeModel: Codable {
    let order_product_id: String
    let name: String
    let value: String
    let price: Float
    init() {
        order_product_id = ""
        name = ""
        value=""
        price=0
    }
    enum CodingKeys: String, CodingKey {
        case order_product_id = "order_product_id"
        case name = "name"
        case value = "value"
        case price = "price"
        
    }
}
