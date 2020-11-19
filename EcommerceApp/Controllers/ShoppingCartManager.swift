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
        let preferentces=UserDefaults.standard
        if(preferentces.object(forKey: "cart_list_product_id") != nil){
            print("has but empty")
            var  cart_list_product_id:[String:[String:String]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[String:String]]
            if(cart_list_product_id[product._id] != nil){
                var currentProduct: [String:String]=cart_list_product_id[product._id]!;
                var quantity1:Int = Int(currentProduct["quantity"]!)!
                quantity1=quantity1+quantity
                currentProduct["quantity"]=String(quantity1)
                cart_list_product_id[product._id]=currentProduct
            }else{
                let jsonProduct: [String:String]  =
                    [
                        "_id": product._id,
                        "id": product.id,
                        "quantity": String(quantity),
                        "name":product.productName!,
                        "imageUrl":product.productImageURL!,
                        "price":String(product.productPrice!),
                        "description":product.productDescription!,
                        "category":product.productCategory!,
                        ]
                cart_list_product_id[product._id]=jsonProduct
            }
            preferentces.set(cart_list_product_id, forKey: "cart_list_product_id")
        }else{
            print("not exists")
            var cart_list_product_id:[String:[String:String]] = [String:[String:String]]()
            let jsonProduct: [String:String]  =
                [
                    "_id": product._id,
                    "id": product.id,
                    "quantity": String(quantity),
                    "name":product.productName!,
                    "imageUrl":product.productImageURL!,
                    "price":String(product.productPrice!),
                    "description":product.productDescription!,
                    "category":product.productCategory!,
                    ]
            
            cart_list_product_id[product._id]=jsonProduct
            //let str_data=convertIntoJSONString(arrayObject: list_key_product)
            print("cart_list_product_id")
            print(cart_list_product_id)
            preferentces.set(cart_list_product_id, forKey: "cart_list_product_id")
            //print("str_data")
            //print(str_data)
        }
       
    }
    func updateProduct(product: Product, quantity: Int = 1) {
         print("update now")
        let preferentces=UserDefaults.standard
        if(preferentces.object(forKey: "cart_list_product_id") != nil){
            var  cart_list_product_id:[String:[String:String]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[String:String]]
            if(cart_list_product_id[product._id] != nil){
                var currentProduct: [String:String]=cart_list_product_id[product._id]!;
                var quantity1:Int = Int(currentProduct["quantity"]!)!
                quantity1=quantity1+quantity
                currentProduct["quantity"]=String(quantity1)
                cart_list_product_id[product._id]=currentProduct
            }
            preferentces.set(cart_list_product_id, forKey: "cart_list_product_id")
        }else{
            print("not exists product in cart")
        }
        
    }
    func removeProduct(_id: String) {
        let preferentces=UserDefaults.standard
        if(preferentces.object(forKey: "cart_list_product_id") != nil){
            var  cart_list_product_id:[String:[String:String]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[String:String]]
            if(cart_list_product_id[_id] != nil){
                cart_list_product_id.removeValue(forKey: _id)
            }
            preferentces.set(cart_list_product_id, forKey: "cart_list_product_id")
        }
    }
    init () {
        
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
        let preferentces=UserDefaults.standard
        if(preferentces.object(forKey: "cart_list_product_id") != nil){
            preferentces.removeObject(forKey: "cart_list_product_id")
        }
        cart.itemDictionary = [:]
        NotificationCenter.default.post(name: kNotificationDidAClearCart, object: nil)
    }
}
