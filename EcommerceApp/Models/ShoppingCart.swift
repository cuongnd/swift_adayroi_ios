//
//  ShoppingCart.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/26/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//
import Foundation
class ShoppingCart {
    var itemDictionary = [String: ShoppingCartItem]()
    init () {
        let preferentces=UserDefaults.standard
        if(preferentces.object(forKey: "cart_list_product_id") != nil){
            let  cart_list_product_id:[String:[String:String]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[String:String]]
            print("cart_list_product_id")
            print(cart_list_product_id)
            for product_item in cart_list_product_id {
                let product_id=product_item.key;
                let name=product_item.value["name"]!
                let _id=product_item.value["_id"]!
                let quantity:Int = Int(product_item.value["quantity"]!)!
                let price:Double = Double(product_item.value["price"]!)!
                let description=product_item.value["description"]!
                let category=product_item.value["category"]!
                let imageUrl=product_item.value["imageUrl"]!
                let product:Product=Product(_id: _id,id: product_id, name: name, imageUrl: imageUrl, price:price, description: description, category: category, images: [])
                itemDictionary[product._id] = ShoppingCartItem(product: product, quantity: quantity)
            }
            
            
        }
        
        //itemDictionary
    }
}
