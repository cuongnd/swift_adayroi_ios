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

class HomeHotCategoryCell: UICollectionViewCell
{
    @IBOutlet weak var cell_view: UIView!
    @IBOutlet weak var img_hot_category: UIImageView!
    @IBOutlet weak var lbl_HotCategoryName: UILabel!
}
class HomeHotProductCell: UICollectionViewCell
{
    @IBOutlet weak var cell_view: UIView!
    @IBOutlet weak var img_hot_product: UIImageView!
    @IBOutlet weak var lbl_HotProductName: UILabel!
}

class HomeVC: UIViewController {
    

    @IBOutlet weak var Collectioview_lastProductList: UICollectionView!
   
    @IBOutlet weak var Collectioview_HomeHotCategoryList: UICollectionView!
    @IBOutlet weak var Collectioview_HomeHotProductList: UICollectionView!
    var lastProductArray = [JSON]()
    var homeHotCategoryArray = [JSON]()
    var homeHotProductArray = [JSON]()
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
        self.Webservice_getHomeLastProducts(url: urlString, params: [:])
        let urlStringHomeCategories = API_URL + "/api/categories"
        self.Webservice_getHomeHotCategories(url: urlStringHomeCategories, params: [:])
        let urlStringHomeHotProduct = API_URL + "/api/products"
        self.Webservice_getHomeHotProducts(url: urlStringHomeHotProduct, params: [:])
       
    }
    
    
}
extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.Collectioview_lastProductList{
            return lastProductArray.count
        }else if collectionView == self.Collectioview_HomeHotCategoryList{
            return homeHotCategoryArray.count
        }else if collectionView == self.Collectioview_HomeHotProductList{
                return homeHotProductArray.count
            }else{
            
        }
        return 0
         
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Collectioview_lastProductList{
            let cell = self.Collectioview_lastProductList.dequeueReusableCell(withReuseIdentifier: "HomeLastProductCell", for: indexPath) as! HomeLastProductCell
            //cornerRadius(viewName: cell.img_categories, radius: 6.0)
            let data = self.lastProductArray[indexPath.item]
            cell.lbl_ProductName.text = data["name"].stringValue
            let productImage = data["default_photo"].dictionaryValue
            cell.img_product.sd_setImage(with: URL(string: productImage["img_path"]!.stringValue), placeholderImage: UIImage(named: "placeholder_image"))
             return cell
        }else if collectionView == self.Collectioview_HomeHotCategoryList{
            let cell = self.Collectioview_HomeHotCategoryList.dequeueReusableCell(withReuseIdentifier: "HomeHotCategoryCell", for: indexPath) as! HomeHotCategoryCell
            //cornerRadius(viewName: cell.img_categories, radius: 6.0)
            let data = self.homeHotCategoryArray[indexPath.item]
            cell.lbl_HotCategoryName.text = data["name"].stringValue
            let categoryImage = data["default_photo"].dictionaryValue
            cell.img_hot_category.sd_setImage(with: URL(string: categoryImage["img_path"]!.stringValue), placeholderImage: UIImage(named: "placeholder_image"))
             return cell
        }else if collectionView == self.Collectioview_HomeHotProductList{
                let cell = self.Collectioview_HomeHotProductList.dequeueReusableCell(withReuseIdentifier: "HomeHotProductCell", for: indexPath) as! HomeHotProductCell
                //cornerRadius(viewName: cell.img_categories, radius: 6.0)
                let data = self.homeHotProductArray[indexPath.item]
                cell.lbl_HotProductName.text = data["name"].stringValue
                let product_Image = data["default_photo"].dictionaryValue
                cell.img_hot_product.sd_setImage(with: URL(string: product_Image["img_path"]!.stringValue), placeholderImage: UIImage(named: "placeholder_image"))
                 return cell
            }else{
            let cell = self.Collectioview_lastProductList.dequeueReusableCell(withReuseIdentifier: "HomeLastProductCell", for: indexPath) as! HomeLastProductCell
            //cornerRadius(viewName: cell.img_categories, radius: 6.0)
            let data = self.lastProductArray[indexPath.item]
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
    func Webservice_getHomeLastProducts(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let homeLastProductData = jsonResponse!["data"].arrayValue
                    self.lastProductArray = homeLastProductData
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
    func Webservice_getHomeHotCategories(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let homeCategoryData = jsonResponse!["data"].arrayValue
                    self.homeHotCategoryArray = homeCategoryData
                    self.Collectioview_HomeHotCategoryList.delegate = self
                    self.Collectioview_HomeHotCategoryList.dataSource = self
                    self.Collectioview_HomeHotCategoryList.reloadData()
                    
                    
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    func Webservice_getHomeHotProducts(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let homeHotProductsData = jsonResponse!["data"].arrayValue
                    self.homeHotProductArray = homeHotProductsData
                    self.Collectioview_HomeHotProductList.delegate = self
                    self.Collectioview_HomeHotProductList.dataSource = self
                    self.Collectioview_HomeHotProductList.reloadData()
                    
                    
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    
}
