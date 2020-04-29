//
//  StoryboardEntityProvider.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

class StoryboardEntityProvider {

    let ecommerceStoryboard = UIStoryboard(name: "Ecommerce", bundle: nil)
    
    func get_view_and_layout(view:String,controller:String) -> LibMvcViewController {
        let vc = UIStoryboard(name: view, bundle: nil).instantiateViewController(withIdentifier: controller+"ViewController") as! LibMvcViewController
       vc.title = "some title"
        return vc
    }
    func ecommerceProductCollectionVC() -> ProductCollectionViewController {
        let vc = ecommerceStoryboard.instantiateViewController(withIdentifier: "ProductCollectionViewController") as! ProductCollectionViewController
        vc.products = Product.mockProducts()
        return vc
    }
    func ecommerceSubCategoriesVC() -> SubCategoriesViewController {
        let vc = ecommerceStoryboard.instantiateViewController(withIdentifier: "SubCategoriesViewController") as! SubCategoriesViewController
        return vc
    }

    func ecommerceProductDetailsVC() -> ProductDetailsViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
    }
   
    func paymentVC() -> PaymentsViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "PaymentsViewController") as! PaymentsViewController
    }
    
    func ecommerceCartVC() -> CartTableViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "CartTableViewController") as! CartTableViewController
    }

    func settingsVC() -> UITableViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! UITableViewController
    }

    func categoriesVC() -> CategoriesTableViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "CategoriesTableViewController") as! CategoriesTableViewController
    }
    func homeVC() -> HomeViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
    func Product_Details_Full_Description_View_VC() -> ProductDetailsFullDescriptionViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "ProductDetailsFullDescriptionViewController") as! ProductDetailsFullDescriptionViewController
    }
    func AddressCheckoutViewControllerVC() -> AddressCheckoutViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "AddressCheckoutViewController") as! AddressCheckoutViewController
    }
    func SumaryCheckoutViewControllerVC() -> SumaryCheckoutViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "SumaryCheckoutViewController") as! SumaryCheckoutViewController
    }
    
    func thankyouViewController() -> ThankyouViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "ThankyouViewController") as! ThankyouViewController
    }
    func mapPathViewController() -> MapPathViewController {
        return ecommerceStoryboard.instantiateViewController(withIdentifier: "MapPathViewController") as! MapPathViewController
    }
}
