//
//  Cart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/4/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import Foundation
class ADRFrontEndModelCartItems: ADRModel {
    static func getList() -> AnySequence<Row>? {
        do{
            return try Database.shared.connection?.prepare(ADRTableCart.shared.table)
        }catch{
            let nsError=error as NSError
            print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return nil
        }
    }
    
    
    
}
