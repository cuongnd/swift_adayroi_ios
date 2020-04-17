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


class ByNowViewController: UIViewController {
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
    @IBOutlet weak var bodyDescriptionContentView: UIView!
    @IBOutlet weak var UIWebViewDescription: UIWebView!
    @IBOutlet var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var UIButtonShowFullDescription: RaisedButton!
    
    
    @IBOutlet weak var footerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let images = product?.productImages {
            pageControl.numberOfPages = images.count
        }
        self.UIWebViewDescription.scrollView.isScrollEnabled = false;
        self.UIWebViewDescription.scrollView.bounces = false;
       
        self.rest_api_get_detail_product()
   
        //updateContentViewHeight()
    }
    func rest_api_get_detail_product() {
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
                            print("json_product")
                            print(json_product["productTitle"]!)
                            self.product = Product(id: json_product["id"]! as! String,name: json_product["productTitle"]! as! String, imageUrl: json_product["default_photo"]!["img_path"] as! String,price: json_product["productPrice"]! as! Double,description: "sdfds",category: "sdfds", images: ["https://cbu01.alicdn.com/img/ibank/2018/961/739/9144937169_1182200648.jpg"])
                            let description:String=json_product["productDescription"]! as! String;
                            self.UILabelProductName.text=json_product["productTitle"]! as? String
                            self.full_description=description+"<style type=\"text/css\">image{width: 100%;!important;}</style>"
                            self.UIWebViewDescription.loadHTMLString(description, baseURL: Bundle.main.bundleURL)
                            for current_image in json_product["images"] as! [[String: AnyObject]] {
                                var image: Image
                                image = Image(id: current_image["img_id"] as! String,name: current_image["img_desc"] as! String, imageUrl: current_image["img_path"] as! String)
                                self.images.append(image);
                                
                            }
                            self.collectionView!.reloadData()
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
    
    fileprivate func updateContentViewHeight() {
        _ = UIDevice.current.orientation
        let constant: CGFloat = self.UIWebViewDescription.frame.size.height 
        if contentViewHeightConstraint.constant != constant {
            
            contentViewHeightConstraint.constant = constant
            
            
        }
       
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

extension ByNowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

