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
        let vc = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductCollectionViewController") as! ProductCollectionViewController
        vc.products = Product.mockProducts()
        return vc
    }
    func ecommerceSubCategoriesVC() -> SubCategoriesViewController {
        let vc = UIStoryboard(name: "SubCategories", bundle: nil).instantiateViewController(withIdentifier: "SubCategoriesViewController") as! SubCategoriesViewController
        return vc
    }

    func ecommerceProductDetailsVC() -> ProductDetailsViewController {
        return  UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
    }
   
    func paymentVC() -> PaymentsViewController {
        return UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "PaymentsViewController") as! PaymentsViewController
    }
    
    func ecommerceCartVC() -> CartTableViewController {
        return UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "CartTableViewController") as! CartTableViewController
    }

    func settingsVC() -> UITableViewController {
        return UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SettingsTableViewController") as! UITableViewController
    }

    func categoriesVC() -> CategoriesTableViewController {
        return UIStoryboard(name: "Categories", bundle: nil).instantiateViewController(withIdentifier: "CategoriesTableViewController") as! CategoriesTableViewController
    }
    func homeVC() -> HomeViewController {
        return UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
    func Product_Details_Full_Description_View_VC() -> ProductDetailsFullDescriptionViewController {
        return UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsFullDescriptionViewController") as! ProductDetailsFullDescriptionViewController
    }
    func AddressCheckoutViewControllerVC() -> AddressCheckoutViewController {
        return UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "AddressCheckoutViewController") as! AddressCheckoutViewController
    }
    func SumaryCheckoutViewControllerVC() -> SumaryCheckoutViewController {
        return UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "SumaryCheckoutViewController") as! SumaryCheckoutViewController
    }
    
    func thankyouViewController() -> ThankyouViewController {
        return UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "ThankyouViewController") as! ThankyouViewController
    }
    func mapPathViewController() -> MapPathViewController {
        return UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "MapPathViewController") as! MapPathViewController
    }
}
