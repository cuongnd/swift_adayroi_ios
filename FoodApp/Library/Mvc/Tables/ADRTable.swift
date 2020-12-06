//
//  ADRTable.swift
//  FoodApp
//
//  Created by MAC OSX on 12/5/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import Foundation
class ADRTable{
   
    public init(){
       
       
    }
    static  func getTable(tableName:String) ->ADRTable {
        let cart = ADRTableCart()
        return cart
    }
    func toString(cart:Row) {
        
    }
    func insert(_id:String,cat_id:String,sub_cat_id:String,original_price:Int64,unit_price:Int64,name:String,image:String,discount_amount:Int64,currency_symbol:String,discount_percent:Int64,color_id:String,color_name:String,quality:Int64 ) -> Int64? {
        return 0
    }
    
    
}
