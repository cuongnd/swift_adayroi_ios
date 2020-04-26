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
    var payment_seleted:Payment? = nil
    @IBOutlet weak var UICollectionViewPayments: UICollectionView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var UILabelTotalCostPayout: UILabel!
    @IBOutlet weak var UILabelTaxShipingCost: UILabel!
    @IBOutlet weak var UILabelShipingCost: UILabel!
    @IBOutlet weak var UILabelTaxCost: UILabel!
    @IBOutlet weak var UILabelTotalCostAffterCouponCode1: UILabel!
    @IBOutlet weak var UILabelTotalCostAfterCouponCode: UILabel!
    @IBOutlet weak var UILabelCouponCost: UILabel!
    var cartManager = ShoppingCartManager();
   
    
    
    @IBOutlet weak var UILabelTotalProduct: UILabel!
    
    
    @IBOutlet weak var UILabelTotalCostBeforeTax: UILabel!
    
    
    
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
    
    UILabelTotalProduct.text=String(describing: cartManager.distinctProductCount())
    UILabelTotalCostBeforeTax.text=String(describing:cartManager.totalPrice())+" VNĐ"
    UILabelCouponCost.text="chưa áp dụng"
    UILabelTotalCostAfterCouponCode.text=String(describing:cartManager.totalPrice())+" VNĐ"
    UILabelTotalCostAffterCouponCode1.text=String(describing:cartManager.totalPrice())+" VNĐ"
    UILabelShipingCost.text="Chưa xác định"
    UILabelTaxShipingCost.text="Chưa xác định"
    UILabelTaxCost.text="Chưa xác định"
    UILabelTotalCostPayout.text=String(describing:cartManager.totalPrice())+" VNĐ"
    
    
    
        self.rest_api_get_payment()
    }
    
    @IBAction func go_to_back_summary(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func completed_order(_ sender: UIButton) {
        if(self.payment_seleted==nil){
            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng chọn phương thức thanh toán", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }else{
            let payment_type=payment_seleted?.payment_type
            if(payment_type=="code" || payment_type=="bank_transfer"){
                let thankyouViewController = StoryboardEntityProvider().thankyouViewController()
                self.navigationController?.setViewControllers([thankyouViewController], animated: true)
            }
        }
        
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
                                payment_item = Payment(id: current_payment["_id"] as! String,name: current_payment["name"] as! String, imageUrl: current_payment["full_image_path"] as! String,payment_type:current_payment["payment_type"] as! String)
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
        
        cell.configureCell(payment: list_payment[indexPath.row])
        return cell
    }
    
    
  
}
extension PaymentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.payment_seleted=self.list_payment[indexPath.row];
        let cell = UICollectionViewPayments.cellForItem(at: indexPath) as! PaymentCollectionViewCell
        if(cell.isSelected)
        {
            print("isSelected")
            cell.backgroundColor = UIColor.cyan
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PaymentCollectionViewCell {
            if(!cell.isSelected)
            {
                cell.backgroundColor = nil
            }
        }
    }
}


