//
//  HomeVC.swift
//  FoodApp
//
//  Created by Mitesh's MAC on 04/06/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
import LanguageManager_iOS
import SlideMenuControllerSwift
import CoreLocation
import MapKit

class HomeLastProductCell: UICollectionViewCell
{
    @IBOutlet weak var cell_view: UIView!
    @IBOutlet weak var img_product: UIImageView!
    @IBOutlet weak var lbl_ProductName: UILabel!
}



class HomeVC: UIViewController {
    

    @IBOutlet weak var Collectioview_lastProductList: UICollectionView!
   
    
    var categoryArray = [JSON]()
   
    var pageIndex = 1
    var lastIndex = 0
    var SelectedCategoryId = String()
    var selectedindex = 0
    var latitued = String()
    var longitude = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        let urlString = API_URL + "/api/products"
        self.Webservice_getCategory(url: urlString, params: [:])
       
    }
    
    
}
extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return categoryArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Collectioview_lastProductList{
            let cell = self.Collectioview_lastProductList.dequeueReusableCell(withReuseIdentifier: "HomeProductCell", for: indexPath) as! HomeLastProductCell
            //cornerRadius(viewName: cell.img_categories, radius: 6.0)
            let data = self.categoryArray[indexPath.item]
            cell.lbl_ProductName.text = data["name"].stringValue
            let productImage = data["default_photo"].dictionaryValue
            cell.img_product.sd_setImage(with: URL(string: productImage["img_path"]!.stringValue), placeholderImage: UIImage(named: "placeholder_image"))
             return cell
        }else{
            let cell = self.Collectioview_lastProductList.dequeueReusableCell(withReuseIdentifier: "HomeProductCell", for: indexPath) as! HomeLastProductCell
            //cornerRadius(viewName: cell.img_categories, radius: 6.0)
            let data = self.categoryArray[indexPath.item]
            cell.lbl_ProductName.text = data["name"].stringValue
            let productImage = data["default_photo"].dictionaryValue
            cell.img_product.sd_setImage(with: URL(string: productImage["img_path"]!.stringValue), placeholderImage: UIImage(named: "placeholder_image"))
             return cell
        }
        
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width:(UIScreen.main.bounds.width) / 2, height: 120)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
}

extension HomeVC
{
    func Webservice_getCategory(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let categoryData = jsonResponse!["data"].arrayValue
                    self.categoryArray = categoryData
                    self.Collectioview_lastProductList.delegate = self
                    self.Collectioview_lastProductList.dataSource = self
                    self.Collectioview_lastProductList.reloadData()
                    
                    
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    
}
