//
//  ObjectMapperFrontendCart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct OrderAttributeModel: Codable {
    let attribute_id: String
    let name: String
    let value: String
    init() {
        attribute_id = ""
        name = ""
        value=""
    }
    enum CodingKeys: String, CodingKey {
        case attribute_id = "attribute_id"
        case name = "name"
        case value = "value"
        
    }
}
