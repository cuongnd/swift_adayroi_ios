//
//  LibraryUtilitiesUtility.swift
//  EcommerceApp
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//
import UIKit
import Foundation
class LibraryUtilitiesUtility {
    static func redirect(navigationController:UINavigationController, view:String,layout:String) -> Void {
        let ecommerceStoryboard = UIStoryboard(name: "Ecommerce", bundle: nil)
        let view=ecommerceStoryboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        navigationController.pushViewController(view, animated: true)
    }
}
