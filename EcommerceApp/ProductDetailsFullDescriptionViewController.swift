//
//  HomeViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class ProductDetailsFullDescriptionViewController: UIViewController {
    @IBOutlet weak var UIWebViewFullDesciptionProduct: UIWebView!
    var full_description_product:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIWebViewFullDesciptionProduct.loadHTMLString(full_description_product, baseURL: Bundle.main.bundleURL)
        
    }
    
}


