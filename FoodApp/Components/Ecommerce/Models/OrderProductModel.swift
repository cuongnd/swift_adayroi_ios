//
//  ObjectMapperFrontendCart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/6/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import Foundation
struct OrderProductModel: Codable {
    var order_product_id: String
    var order_id: String
    var product_name: String
    var product_description: String
    var total: String
    var quantity: String
    var imageUrl: String
    var created_date: String
    var currency_short_form: String
    var currency_symbol: String
    var discount_amount: String
    var discount_percent: String
    var discount_price: String
    var discount_value: String
    var original_price: String
    var unit_price: String
    var product_attribute_id: String
    var product_id: String
    var product_unit: String
    var qty: String
    var shipping_cost: String
    var list_attribute_value: [OrderAttributeModel]
    var color: [OrderColorModel]
    var isselected:Int=0
    init() {
        order_product_id = ""
        order_id = ""
        product_name = ""
        product_description = ""
        total = ""
        quantity = ""
        imageUrl = ""
        created_date = ""
        currency_short_form = ""
        currency_symbol = ""
        discount_amount = ""
        discount_percent = ""
        discount_price = ""
        discount_value = ""
        original_price = ""
        unit_price = ""
        product_attribute_id = ""
        product_id = ""
        product_unit = ""
        qty = ""
        shipping_cost = ""
       
    }
    enum CodingKeys: String, CodingKey {
            case order_product_id = "order_product_id"
            case order_id = "order_id"
            case product_name = "product_name"
            case product_description = "product_description"
            case total = "total"
            case quantity = "quantity"
            case imageUrl = "imageUrl"
            case created_date = "created_date"
            case currency_short_form = "currency_short_form"
            case currency_symbol = "currency_symbol"
            case discount_amount = "discount_amount"
            case discount_percent = "discount_percent"
            case discount_price = "discount_price"
            case discount_value = "discount_value"
            case original_price = "original_price"
            case unit_price = "unit_price"
            case product_attribute_id = "product_attribute_id"
            case product_id = "product_id"
            case product_unit = "product_unit"
            case qty = "qty"
            case shipping_cost = "shipping_cost"
    }
}
