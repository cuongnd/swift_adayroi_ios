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
        let items:AnySequence<Row> = ADRTableCart.shared.getItemById(id:objectMapperFrontendProduct._id! )!
        
        ADRTableCart.shared.insert(
            _id: objectMapperFrontendProduct._id!,
            cat_id: objectMapperFrontendProduct.cat_id!,
            sub_cat_id: objectMapperFrontendProduct.sub_cat_id!,
            original_price: objectMapperFrontendProduct.original_price!,
            unit_price: objectMapperFrontendProduct.unit_price!,
            name: objectMapperFrontendProduct.name!,
            image: (objectMapperFrontendProduct.default_photo?.img_path!)!,
            discount_amount: objectMapperFrontendProduct.discount_amount!,
            currency_symbol: objectMapperFrontendProduct.currency_symbol!,
            discount_percent: objectMapperFrontendProduct.discount_percent!,
            color_id:"color_id",
            color_name: "color name",
            quality: quanlity
        )
    }
    
}
