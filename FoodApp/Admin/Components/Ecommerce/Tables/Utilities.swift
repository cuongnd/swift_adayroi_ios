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
class Utilities{
    
        static func randomString(length: Int) -> String {
         let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
         return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
}
