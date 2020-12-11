//
//  ObjectMapperFrontendCart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct PaymentModel: Codable {
    let _id: String
    let name: String
    let default_photo: ImageModel
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
        case default_photo = "default_photo"
        
    }
}
