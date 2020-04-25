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


class AddressCheckoutViewController: UIViewController {
    var product: Product? {
        didSet {
            
            self.title = product?.productName
            
            
            self.view.setNeedsLayout()
        }
    }
    @IBOutlet weak var UIScrollViewDetailProduct: UIScrollView!
     var bodyContentHeight:CGFloat = 0.0
    var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var UILabelProductName: UILabel!
    var images=[Image]();
    var product_id:String=""
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var detailsTextView: UITextView!
    @IBOutlet var addToCartButton: RaisedButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bodyContentView: UIView!
    var full_description:String=""
    
    
    @IBAction func add_to_cart(_ sender: Any) {
    }
    @IBOutlet weak var footerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let images = product?.productImages {
            pageControl.numberOfPages = images.count
        }
      
       
        
        
       
   
        //updateContentViewHeight()
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

extension AddressCheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionView.frame.size.width
        pageControl.currentPage = Int(self.collectionView.contentOffset.x / pageWidth)
    }
}

