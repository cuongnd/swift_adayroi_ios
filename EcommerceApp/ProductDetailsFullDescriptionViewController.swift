//
//  ProductDetailsViewController.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/22/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Material
import UIKit




class ProductDetailsFullDescriptionViewController: UIViewController {
    
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
        
        //self.UIWebViewDescription.loadHTMLString(self.full_description, baseURL: Bundle.main.bundleURL)
        //updateContentViewHeight()
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

}



