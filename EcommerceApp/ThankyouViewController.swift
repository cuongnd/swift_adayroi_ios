//
//  SubCategoriesViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class ThankyouViewController: UIViewController {
    var reuseIdentifier:String=""
    var list_payment=[Payment]()
    var payment_seleted:Payment? = nil
    var order_id:String="";
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
   override func viewDidLoad() {
        super.viewDidLoad()
    
    
    
    
        self.rest_api_get_order()
    }
    @IBOutlet weak var UILabelTotalProduct: UILabel!
    @IBOutlet weak var UILabelOrderNumber: UILabel!
    @IBOutlet weak var UICollectionViewListOrderProducts: UICollectionView!
    func rest_api_get_order() {
        let url = AppConfiguration.root_url+"api/order/"+order_id
        print("url get order")
        print(url)
        let request = NSMutableURLRequest(url: URL(string: url)!)
        print("now start load categories data")
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            } else {
                if let content = data {
                    DispatchQueue.main.async {
                        do {
                            //array
                            let order_json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            print("response payment")
                            print(order_json)
                            //self.UICollectionViewListOrderProducts.reloadData()
                            self.activityIndicator.stopAnimating()
                        } catch {
                            print("load error slideshow")
                        }
                    }
                }
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
                print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
            }
            
            
            if error == nil {
                // Ce que vous voulez faire.
            }
        }
        requestAPI.resume()
        
        
    }
    
   
    
}



