//
//  ProductDetailsViewController.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/22/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Material
import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"


class SumaryCheckoutViewController: UIViewController {
    var product: Product? {
        didSet {
            
            self.title = product?.productName
            
            
            self.view.setNeedsLayout()
        }
    }
    @IBOutlet weak var UILabelTotalCostPayout: UILabel!
    @IBOutlet weak var UILabelTaxShipingCost: UILabel!
    @IBOutlet weak var UILabelShipingCost: UILabel!
    @IBOutlet weak var UILabelTaxCost: UILabel!
    @IBOutlet weak var UILabelTotalCostAffterCouponCode1: UILabel!
    @IBOutlet weak var UILabelTotalCostAfterCouponCode: UILabel!
    @IBOutlet weak var UILabelCouponCost: UILabel!
    var cartManager = ShoppingCartManager();
     var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
   
    @IBOutlet weak var UILabelTotalProduct: UILabel!
    
    
    @IBOutlet weak var UILabelTotalCostBeforeTax: UILabel!
    @IBAction func UIButtonCheckCoupon(_ sender: UIButton) {
        return;
        let coupon_code=UITextFieldCouponCode.text;
        
        if(coupon_code!.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            UITextFieldCouponCode.text=""
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập mã coupon", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let url = AppConfiguration.root_url+"api/products/"+product_id
        print("url")
        print(url)
        let request = NSMutableURLRequest(url: URL(string: url)!)
        
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            } else {
                if let content = data {
                    DispatchQueue.main.async {
                        do {
                            //array
                            let json_product = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                            
                            let alert = UIAlertController(title: "Thông báo", message: "Mã coupon không hơp lệ", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                            self.activityIndicator.stopAnimating()
                            UIApplication.shared.beginIgnoringInteractionEvents()
                            
                            
                            
                            
                            
                        } catch {
                            
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
    @IBOutlet weak var UITextFieldCouponCode: UITextField!
    var jsonAddressShippingAndBinding: [String:String] = [:]
     var bodyContentHeight:CGFloat = 0.0
    var heightConstraint: NSLayoutConstraint!
    var images=[Image]();
    var product_id:String=""
    var full_description:String=""
    
    @IBAction func go_to_payment(_ sender: UIButton) {
        let paymentVC = StoryboardEntityProvider().paymentVC()
        paymentVC.data_order = self.jsonAddressShippingAndBinding;
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    @IBAction func go_to_back_address(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func add_to_cart(_ sender: Any) {
    }
    @IBOutlet weak var footerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateContentViewHeight()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        UILabelTotalProduct.text=String(describing: cartManager.distinctProductCount())
        UILabelTotalCostBeforeTax.text=String(describing:cartManager.totalPrice())+" VNĐ"
        UILabelCouponCost.text="chưa áp dụng"
        UILabelTotalCostAfterCouponCode.text=String(describing:cartManager.totalPrice())+" VNĐ"
        UILabelTotalCostAffterCouponCode1.text=String(describing:cartManager.totalPrice())+" VNĐ"
        UILabelShipingCost.text="Chưa xác định"
        UILabelTaxShipingCost.text="Chưa xác định"
        UILabelTaxCost.text="Chưa xác định"
        UILabelTotalCostPayout.text=String(describing:cartManager.totalPrice())+" VNĐ"
        
        
    }
   
  
    @IBAction func show_full_description_product(_ sender: UIButton) {
        let Product_Details_Full_Description_View_VC = StoryboardEntityProvider().Product_Details_Full_Description_View_VC()
        Product_Details_Full_Description_View_VC.full_description_product=self.full_description
        self.navigationController?.pushViewController(Product_Details_Full_Description_View_VC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(product?.id ?? "nothing")
        //self.detailsTextView.text = product?.productDescription

       
        //updateContentViewHeight()
    }
    
    
    @objc
    fileprivate func didTapShowFullDescriptionButton() {
        
    }
    @objc
    fileprivate func didTapAddToCartButton() {
        NotificationCenter.default.post(name: kNotificationDidAddProductToCart, object: nil, userInfo: ["product": product ?? nil])
        self.navigationController?.popViewController(animated: true)
    }
}

extension SumaryCheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        print("image123")
        print(self.images[indexPath.row].imageURL!)
        cell.configureCell(imageUrl: self.images[indexPath.row].imageURL!)
        return cell
    }

    
}

