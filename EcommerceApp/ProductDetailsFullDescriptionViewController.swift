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


class ProductDetailsFullDescriptionViewController: UIViewController {
    var product: Product? {
        didSet {
            
            self.title = product?.productName
            self.view.setNeedsLayout()
        }
    }
    @IBOutlet weak var UIScrollViewDetailProduct: UIScrollView!
     var bodyContentHeight:CGFloat = 0.0
    var full_description:String=""
    var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var UILabelProductName: UILabel!
    var images=[Image]();
    var product_id:String=""
    @IBOutlet weak var UIWebViewDescription: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.UIWebViewDescription.loadHTMLString(self.full_description, baseURL: Bundle.main.bundleURL)
        //updateContentViewHeight()
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
    fileprivate func didTapAddToCartButton() {
        NotificationCenter.default.post(name: kNotificationDidAddProductToCart, object: nil, userInfo: ["product": product ?? nil])
        self.navigationController?.popViewController(animated: true)
    }
}



