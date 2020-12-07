//
//  ADRTableCart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/5/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import SwiftyJSON
import Foundation
class ADRTableCartAttribute: ADRTable{
    static let shared: ADRTableCartAttribute = {
        let instance = ADRTableCartAttribute()
        // Setup code
        return instance
    }()
    public var context: String = "ADRTableCartAttribute"
    public var table: Table = Table("ADRTableCartAttribute")
    private let id=Expression<Int64>("id")
    private let cart_id=Expression<Int64>("cart_id")
    private let _id=Expression<String>("_id")
    private let key_name=Expression<String>("key_name")
    private let name=Expression<String>("name")
    private let header_id=Expression<String>("header_id")
    private let additional_price=Expression<Int64>("additional_price")
    private let product_id=Expression<String>("product_id")
    
    override public   init(){
        super.init()
        do{
            if let connection=Database.shared.connection{
                try connection.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block:{ (table) in
                    table.column(self.id,primaryKey: true)
                    table.column(self._id)
                    table.column(self.cart_id)
                    table.column(self.key_name)
                    table.column(self.name)
                    table.column(self.header_id)
                    table.column(self.additional_price)
                    table.column(self.product_id)
                    
                }))
                print("Create table Cart successfully")
            }else{
                print("Create table Cart error")
            }
        } catch{
            let nsError=error as NSError
            print("Creoverride ate table Cart error. Error is \(nsError), \(nsError.userInfo)")
        }
    }
    override func toString(cart:Row) {
        
    }
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
    
    func insert(
        _id:String,
        cart_id:Int64,
        key_name:String,
        name:String,
        header_id:String,
        additional_price:Int64,
        product_id:String
         ) -> Int64? {
        do{
            let insert=table.insert(
                self._id<-_id,
                self.cart_id<-cart_id,
                self.key_name<-key_name,
                self.name<-name,
                self.header_id<-header_id,
                self.additional_price<-additional_price,
                self.product_id<-product_id
            )
            let insertId=try Database.shared.connection!.run(insert)
            return insertId
        }catch{
            let nsError=error as NSError
            print("insert new table Cart error. Eoverride rror is \(nsError), \(nsError.userInfo)")
            return nil
        }
    }
    
    func DeleteCartAttributeByCartId(cart_id:Int64)->Bool{
        do{
            let filter=table.filter(self.cart_id==cart_id);
            let delete=try Database.shared.connection!.run(filter.delete())
            return true
        }catch{
            let nsError=error as NSError
            print("insert new table Cart error. Eoverride rror is \(nsError), \(nsError.userInfo)")
            return false
        }
        
        return true;
    }
    
    func queryCountAll()->Int{
        do{
            return try Database.shared.connection?.scalar(self.table.count) as! Int
        }catch{
            let nsError=error as NSError
            print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return 0
        }
    }
    
    
    func queryAll() -> AnySequence<Row>? {
        do{
            return try Database.shared.connection?.prepare(self.table)
        }catch{
            let nsError=error as NSError
            print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return nil
        }
    }
    
    
}
