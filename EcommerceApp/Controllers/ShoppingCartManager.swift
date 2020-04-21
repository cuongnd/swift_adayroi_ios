//
//  ShoppingCartManager.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/24/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Foundation

let kNotificationDidAddProductToCart = NSNotification.Name(rawValue: "kNotificationDidAddProductToCart")
let kNotificationDidAClearCart = NSNotification.Name(rawValue: "kNotificationDidAClearCart")

class ShoppingCartManager {

    var cart = ShoppingCart()

    func addProduct(product: Product, quantity: Int = 1) {
        if let item = cart.itemDictionary[product.id] {
            item.quantity += quantity
            return
        }
        cart.itemDictionary[product.id] = ShoppingCartItem(product: product, quantity: quantity)
        let preferentces=UserDefaults.standard
        if(preferentces.object(forKey: "cart_list_product_id") != nil){
            var  cart_list_product_id:[String:[Any]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[Any]]
            let jsonObject: [Any]  = [
                [
                    "id": product.id,
                    "quantity": quantity,
                    ]
            ]
            cart_list_product_id[product.id]=jsonObject
            preferentces.set(cart_list_product_id, forKey: "cart_list_product_id")
        }else{
            var cart_list_product_id:[String:[Any]] = [String:[Any]]()
            for product_item in cart.itemDictionary {
                let jsonObject: [Any]  = [
                    [
                        "id": product_item.key,
                        "quantity": quantity,
                    ]
                ]
                cart_list_product_id[product_item.key]=jsonObject
            }
            //let str_data=convertIntoJSONString(arrayObject: list_key_product)
            print("cart_list_product_id")
            print(cart_list_product_id)
            preferentces.set(cart_list_product_id, forKey: "cart_list_product_id")
            //print("str_data")
            //print(str_data)
        }
       
    }
   
    init () {
        let preferentces=UserDefaults.standard
        if(preferentces.object(forKey: "cart_list_product_id") != nil){
            let  cart_list_product_id:[String:[Any]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[Any]]
            print("cart_list_product_id")
            print(cart_list_product_id)
            
        }
    }
    func productCount() -> Int {
        return cart.itemDictionary.reduce(0) { (x, entry: (key: String, value: ShoppingCartItem)) -> Int in
            return x + entry.value.quantity
        }
    }

    func distinctProducts() -> [Product] {
        return cart.itemDictionary.values.map({$0.product})
    }

    func distinctProductCount() -> Int {
        return self.distinctProducts().count
    }

    func distinctProductItems() -> [ShoppingCartItem] {
        return cart.itemDictionary.values.map({$0})
    }

    func totalPrice() -> Double {
        return cart.itemDictionary.reduce(0.0) { (x, entry: (key: String, value: ShoppingCartItem)) -> Double in
            if let price = entry.value.product.productPrice {
                return x + Double(entry.value.quantity) * price
            }
            return x
        }
    }

    func clearProducts() {
        cart.itemDictionary = [:]
        NotificationCenter.default.post(name: kNotificationDidAClearCart, object: nil)
    }
}
