//
//  Cart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/4/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import Foundation
class Cart: Model {
    static let shared=Cart()
    let tableCart=Table("Cart")
    override var  context: String {
      return "Cart"
    }
    private let id = Expression<Int64>("id")
    private let _id = Expression<String>("_id")
    private let name=Expression<String>("name")
    private override init(){
        super.init()
        do{
            if let connection=Database.shared.connection{
                try connection.run(tableCart.create(temporary: false, ifNotExists: true, withoutRowid: false, block:{ (table) in
                    table.column(self.id,primaryKey: true)
                    table.column(self._id)
                    table.column(self.name)
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
        print("Cart detail id=\(cart[self.id]), _id=\(cart[self._id]), name=\(cart[self.name])")
    }
    func insert(id:String,name:String ) -> Int64? {
        do{
            let insert=tableCart.insert(self._id<-id,self.name<-name)
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
