//
//  SubCategoriesViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController {
    var reuseIdentifier:String=""
    var list_payment=[Payment]()
    
    @IBOutlet weak var UICollectionViewPayments: UICollectionView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
   override func viewDidLoad() {
        super.viewDidLoad()
        UICollectionViewPayments.delegate=self
        UICollectionViewPayments.dataSource=self
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    
    
        self.rest_api_get_payment()
    }
    
    func rest_api_get_payment() {
        let url = AppConfiguration.root_url+"api/payments/"
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
                            let payment_json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            self.list_payment=[Payment]()
                            for current_payment in payment_json as! [[String: AnyObject]] {
                                var payment_item: Payment
                                payment_item = Payment(id: current_payment["_id"] as! String,name: current_payment["name"] as! String, imageUrl: current_payment["default_photo"]!["img_path"] as! String)
                                self.list_payment.append(payment_item);
                                
                            }
                            print("response payment")
                            print(self.list_payment)
                            self.UICollectionViewPayments.reloadData()
                            self.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
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
extension PaymentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return list_payment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewPayments.dequeueReusableCell(withReuseIdentifier:"cell_payment", for: indexPath) as! PaymentCollectionViewCell
        
        //cell.configureCell(payment: list_payment[indexPath.row])
        return cell
    }
    
    
  
}
extension PaymentsViewController: UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


