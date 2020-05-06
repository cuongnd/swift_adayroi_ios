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
    var list_product=[Product]()
    var payment_seleted:Payment? = nil
    var order_id:String="";
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var UILabelTotalProduct: UILabel!
    @IBOutlet weak var UILabelOrderNumber: UILabel!
    @IBOutlet weak var UICollectionViewOrderProducts: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UICollectionViewOrderProducts.dataSource=self
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
                            
                            print(order_json)
                           
                            self.list_product=[Product]()
                            for current_product in (order_json["list_product"] as? [[String : AnyObject]])!{
                                
                                var product: Product
                                product = Product(_id: current_product["_id"]! as! String,id: current_product["_id"]! as! String, name: current_product["product_name"]! as! String, imageUrl: current_product["imageUrl"]! as! String, price: 0, description: "", category: "", images: [])
                                self.list_product.append(product);
                            }
                            
                            
                            
                            
                            self.UICollectionViewOrderProducts.reloadData()
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
                print("réponse = \(String(describing: response))") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
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
extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return list_product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewOrderProducts.dequeueReusableCell(withReuseIdentifier:"cell_product", for: indexPath) as! FrontEndViewOrdersTmplProductCollectionViewCell
        
        cell.configureCell(total:100.0,product: list_product[indexPath.row])
        return cell
    }
    
    
    
}

