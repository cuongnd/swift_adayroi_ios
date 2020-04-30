//
//  SubCategoriesViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class OrderViewController: LibMvcViewController {
    var reuseIdentifier:String=""
    var list_payment=[Payment]()
    var payment_seleted:Payment? = nil
    var order_id:String="";
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    func test(order_id:String) {
        self.order_id=order_id
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.rest_api_get_order();
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
                            
                            print("response order")
                            print(order_json)
                            //self.UICollectionViewListOrderProducts.reloadData()
                            self.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                        } catch {
                            print("load error order")
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
    @objc
    fileprivate func didSendOrderIdNotification(notification: Notification) {
        print("hello didSendOrderIdNotification order")
        guard let order_id = notification.userInfo?["order_id"] as? String else {
            return
        }
        print(order_id)
    }
    
    
    
}



