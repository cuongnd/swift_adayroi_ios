//
//  AddtoCartVC.swift
//  FoodApp
//
//  Created by Mitesh's MAC on 04/06/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite
import RxSwift
import RxCocoa
import Foundation
import Alamofire
import SlideMenuControllerSwift

class orderProductCell: UICollectionViewCell {
    
    @IBOutlet weak var UILabelProductName: UILabel!
    @IBOutlet weak var UILabelPrice: UILabel!
    @IBOutlet weak var UILabelTotal: UILabel!
    @IBOutlet weak var UIImageViewProduct: UIImageView!
    @IBOutlet weak var UICollectionViewAttributeNameValue: UICollectionView!
    @IBOutlet weak var UIImageViewColor: UIImageView!
    @IBOutlet weak var UILabelColorValue: UILabel!
    
}
class orderProductAttributeValueCell: UICollectionViewCell {
    @IBOutlet weak var UILabelAttributeName: UILabel!
    @IBOutlet weak var UILabelAttributeKeyValue: UILabel!
}
class ADRFrontEndViewCheckoutThankyouVC: UIViewController {
    
    @IBOutlet weak var UIButtonHomePage: UIButton!
    @IBOutlet weak var UICollectionViewOrderProducts: UICollectionView!
    @IBOutlet weak var UILabelDiscountAmount: UILabel!
    @IBOutlet weak var UILabelTax: UILabel!
    
    @IBOutlet weak var UILabelBillingAddress2: UILabel!
    @IBOutlet weak var UILabelBillingAddress1: UILabel!
    @IBOutlet weak var UILabelBillingEmail: UILabel!
    @IBOutlet weak var UILabelBillingPhone: UILabel!
    @IBOutlet weak var UILabelShippingAddress2: UILabel!
    @IBOutlet weak var UILabelAddress1: UILabel!
    @IBOutlet weak var UILabelShippingEmail: UILabel!
    @IBOutlet weak var UILabelShippingPhone: UILabel!
    @IBOutlet weak var UILabelTotalCostAfterTax: UILabel!
    @IBOutlet weak var UILabelShippingCost: UILabel!
    @IBOutlet weak var UILabelShippingTax: UILabel!
    @IBOutlet weak var UILabelOrderStatus: UILabel!
    @IBOutlet weak var UILabelTotalCostAfterDiscount: UILabel!
    @IBOutlet weak var UILabelTotalCostBeforPrice: UILabel!
    @IBOutlet weak var UILabelTotalProduct: UILabel!
    @IBOutlet weak var UILabelBtnCopy: UILabel!
    @IBOutlet weak var UILabelOrderNumber: UILabel!
    var order_id:String=""
    @IBOutlet weak var UIButtonNext: UIButton!
    @IBOutlet weak var UIButtonBack: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    var list_product:[OrderProductModel]=[OrderProductModel]()
    @IBOutlet weak var UICollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "orderProductCell", bundle: nil)
        self.UICollectionViewOrderProducts.register(nib, forCellWithReuseIdentifier: "cell")
        
        
        
        let urlStringPostUpdateUser = API_URL + "/api/orders/\(self.order_id)"
        self.Webservice_getOrderInfo(url: urlStringPostUpdateUser, params: [:])
        
        
        
        
    }
    @IBAction func UIButtonHomePageClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
    @IBAction func UIButtonTouchUpInsideNext(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ADRFrontEndViewCheckoutPaymentVC") as! ADRFrontEndViewCheckoutPaymentVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
    @IBAction func UIButtonTouchUpInsideBack(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ADRFrontEndViewCheckoutVC") as! ADRFrontEndViewCheckoutVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
}
extension ADRFrontEndViewCheckoutThankyouVC
{
    
    func Webservice_getOrderInfo(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getOrderResponseModel = try jsonDecoder.decode(GetOrderResponseModel.self, from: jsonResponse!)
                    let orderModel:OrderModel=getOrderResponseModel.order
                    self.list_product=orderModel.list_product;

                    self.UICollectionViewOrderProducts.delegate=self
                    self.UICollectionViewOrderProducts.dataSource = self
                    self.UICollectionViewOrderProducts.reloadData()
                    print("orderModel:\(orderModel)")
                } catch let error as NSError  {
                    print("error: \(error)")
                }
                
                
                //print("userModel:\(userModel)")
                
            }
        }
        
        
        
    }
    func Webservice_getUpdateUser(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let data = jsonResponse!["data"].dictionaryValue
                    let vc = self.storyboard?.instantiateViewController(identifier: "ADRFrontEndViewCheckoutSummaryVC") as! ADRFrontEndViewCheckoutSummaryVC
                    self.navigationController?.pushViewController(vc, animated:true)
                    
                    
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    
    
}

extension ADRFrontEndViewCheckoutThankyouVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView==self.UICollectionViewOrderProducts){
            return self.list_product.count
        }else{
            return self.list_product[collectionView.tag].list_attribute_value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView==self.UICollectionViewOrderProducts){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderProductCell", for: indexPath) as! orderProductCell
            let element=self.list_product[indexPath.row]
            cell.UILabelPrice.text=String(element.unit_price)
            cell.UILabelProductName.text=element.product_name
            cell.UILabelTotal.text=String(element.total)
            cell.UILabelColorValue.text=element.color_value
            cell.UICollectionViewAttributeNameValue.delegate=self
            cell.UIImageViewColor.sd_setImage(with: URL(string: element.color_image), placeholderImage: UIImage(named: "placeholder_image"))
            cell.UIImageViewProduct.sd_setImage(with: URL(string: element.imageUrl), placeholderImage: UIImage(named: "placeholder_image"))
            
            cell.UICollectionViewAttributeNameValue.tag = indexPath.row
            cell.UICollectionViewAttributeNameValue.delegate = self
            cell.UICollectionViewAttributeNameValue.dataSource = self
            cell.UICollectionViewAttributeNameValue.reloadData()
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderProductAttributeValueCell", for: indexPath) as! orderProductAttributeValueCell
            let product=self.list_product[collectionView.tag]
            let attribute=product.list_attribute_value[indexPath.row]
            cell.UILabelAttributeName?.text=attribute.name as String
            cell.UILabelAttributeKeyValue?.text=attribute.value as String
            return cell
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("collectionView: \(collectionView)")
        if(collectionView==self.UICollectionViewOrderProducts){
            return CGSize(width: (UIScreen.main.bounds.width) / 1, height: 220.0)
        }else{
            return CGSize(width: (collectionView.bounds.width) / 2, height: 40.0)
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
}

