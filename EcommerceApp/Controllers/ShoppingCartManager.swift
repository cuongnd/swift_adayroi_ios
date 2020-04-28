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
            var  cart_list_product_id:[String:[String:String]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[String:String]]
            if(cart_list_product_id[product.id] != nil){
                var currentProduct: [String:String]=cart_list_product_id[product.id]!;
                var quantity1:Int = Int(currentProduct["quantity"]!)!
                quantity1=quantity1+quantity
                currentProduct["quantity"]=String(quantity1)
                cart_list_product_id[product.id]=currentProduct
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
                cart_list_product_id[product.id]=jsonProduct
            }
            preferentces.set(cart_list_product_id, forKey: "cart_list_product_id")
        }else{
            var cart_list_product_id:[String:[String:String]] = [String:[String:String]]()
            for product_item in cart.itemDictionary {
                let jsonProduct: [String:String]  =
                    [
                        "_id": product._id,
                        "id": product_item.key,
                        "quantity": String(quantity),
                        "name":product.productName!,
                        "imageUrl":product.productImageURL!,
                        "price":String(product.productPrice!),
                        "description":product.productDescription!,
                        "category":product.productCategory!,
                    ]
                
                cart_list_product_id[product_item.key]=jsonProduct
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
            let  cart_list_product_id:[String:[String:String]]=preferentces.value(forKey: "cart_list_product_id")! as! [String:[String:String]]
            print("cart_list_product_id")
            print(cart_list_product_id)
            clearProducts();
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
                cart.itemDictionary[product.id] = ShoppingCartItem(product: product, quantity: quantity)
            }
            
            
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
