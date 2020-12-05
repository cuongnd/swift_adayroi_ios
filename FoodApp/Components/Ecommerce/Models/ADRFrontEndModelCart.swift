//
//  Cart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/4/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import Foundation
class ADRFrontEndModelCart: ADRModel {
    static let shared=ADRFrontEndModelCart()
    let tableCart=Table("Cart")
    override var  context: String {
      return "Cart"
    }
    private let _id = Expression<String>("_id")
    private let cat_id=Expression<String>("cat_id")
    private let sub_cat_id=Expression<String>("sub_cat_id")
    private let original_price=Expression<Int64>("original_price")
    private let unit_price=Expression<Int64>("unit_price")
    private let name=Expression<String>("name")
    private let image=Expression<String>("image")
    private let discount_amount=Expression<Int64>("discount_amount")
    private let currency_symbol=Expression<String>("currency_symbol")
    private let discount_percent=Expression<Int64>("discount_percent")
    private let color_id=Expression<String>("color_id")
    private let color_name=Expression<String>("color_name")
    private let quality=Expression<Int64>("quality")
    private override init(){
        super.init()
        do{
            if let connection=Database.shared.connection{
                try connection.run(tableCart.create(temporary: false, ifNotExists: true, withoutRowid: false, block:{ (table) in
                    table.column(self._id,primaryKey: true)
                    table.column(self.cat_id)
                    table.column(self.sub_cat_id)
                    table.column(self.original_price)
                    table.column(self.unit_price)
                    table.column(self.name)
                    table.column(self.image)
                    table.column(self.discount_amount)
                    table.column(self.currency_symbol)
                    table.column(self.discount_percent)
                    table.column(self.color_id)
                    table.column(self.color_name)
                    table.column(self.quality)
                }))
                print("Create table Cart successfully")
            }else{
                print("Create table Cart error")
            }
        } catch{
            let nsError=error as NSError
            print("Create table Cart error. Error is \(nsError), \(nsError.userInfo)")
        }
    }
    func toString(cart:Row) {
        print("Cart detail: _id=\(cart[self._id]), cat_id=\(cart[self.cat_id]), sub_cat_id=\(cart[self.sub_cat_id]), original_price=\(cart[self.original_price]), unit_price=\(cart[self.unit_price]),name=\(cart[self.name]),image=\(cart[self.image]), discount_amount=\(cart[self.discount_amount]), currency_symbol=\(cart[self.currency_symbol]), discount_percent=\(cart[self.discount_percent]), color_id=\(cart[self.color_id]), color_name=\(cart[self.color_name]), quality=\(cart[self.quality])")
    }
    func insert(_id:String,cat_id:String,sub_cat_id:String,original_price:Int64,unit_price:Int64,name:String,image:String,discount_amount:Int64,currency_symbol:String,discount_percent:Int64,color_id:String,color_name:String,quality:Int64 ) -> Int64? {
        do{
            let insert=tableCart.insert(
                self._id<-_id,
                self.cat_id<-cat_id,
                self.sub_cat_id<-sub_cat_id,
                self.original_price<-original_price,
                self.unit_price<-unit_price,
                self.name<-name,
                self.image<-image,
                self.discount_amount<-discount_amount,
                self.currency_symbol<-currency_symbol,
                self.discount_percent<-discount_percent,
                self.color_id<-color_id,
                self.color_name<-color_name,
                self.quality<-quality
            )
            let insertId=try Database.shared.connection!.run(insert)
            return insertId
        }catch{
            let nsError=error as NSError
            print("insert new table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return nil
        }
    }
    func queryAll() -> AnySequence<Row>? {
        do{
            return try Database.shared.connection?.prepare(self.tableCart)
        }catch{
            let nsError=error as NSError
            print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return nil
        }
    }
    
}
