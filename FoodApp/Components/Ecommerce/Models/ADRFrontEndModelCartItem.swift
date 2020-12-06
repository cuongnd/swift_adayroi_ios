//
//  Cart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/4/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import Foundation
class ADRFrontEndModelCartItem: ADRModel {
    static let shared: ADRFrontEndModelCartItem = {
        let instance = ADRFrontEndModelCartItem()
        // Setup code
        return instance
    }()
    private override init() {}
    func addToCcart(objectMapperFrontendProduct:ObjectMapperFrontendProduct,quanlity:Int64) -> Void {
        
    }
    
}
