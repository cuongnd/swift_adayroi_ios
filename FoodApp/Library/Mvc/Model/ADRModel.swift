//
//  Model.swift
//  FoodApp
//
//  Created by MAC OSX on 12/4/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit

var sharedInstanceArray=[ADRModel]()
class ADRModel: NSObject {
    public var context: String {
      return ""
    }
    
    static func getInstance(modelName:String)->ADRModel{
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
            let cart = ADRFrontEndModelCartItem()
            return cart
        default:
            let temp = ADRFrontEndModelCartItem()
            return temp
        }
    }
    
}
