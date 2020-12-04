//
//  Model.swift
//  FoodApp
//
//  Created by MAC OSX on 12/4/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit

var sharedInstanceArray=[Model]()
class Model: NSObject {
    public var context: String {
      return ""
    }
    /*
    static func getInstance(modelName:String)->Model{
        if(sharedInstanceArray.count>0){
            for index in 0...sharedInstanceArray.count-1{
                let currentModel=sharedInstanceArray[index]
                if(currentModel.context==modelName){
                    return currentModel
                }
            }
        }
        switch modelName {
        case "Cart":
            let cart = Cart()
            return cart
        default:
            let temp = Temp()
            return temp
        }
    }
    */
}
