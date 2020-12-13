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
    
    var order_id:String=""
    @IBOutlet weak var UIButtonNext: UIButton!
       @IBOutlet weak var UIButtonBack: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    var viewmodel: ViewOrderControllerViewModel!
    var disposeBag = DisposeBag()
    var disposeBag1 = DisposeBag()
    var viewmodel2: ViewOrderControllerViewModel2!
    
    @IBOutlet weak var UICollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "orderProductCell", bundle: nil)
        self.UICollectionViewOrderProducts.register(nib, forCellWithReuseIdentifier: "cell")
        self.UICollectionViewOrderProducts.delegate=self
        self.viewmodel = ViewOrderControllerViewModel()
        self.viewmodel2 = ViewOrderControllerViewModel2()
        viewmodel.outputs.list_produt.subscribe{ (event) in
            Observable.of(event.element!).bind(to: self.UICollectionViewOrderProducts.rx.items(cellIdentifier: "orderProductCell", cellType: orderProductCell.self)) { (row, element, cell) in
                print("hello bin")
                
                cell.UILabelPrice.text=String(element.unit_price)
                cell.UILabelProductName.text=element.product_name
                cell.UILabelTotal.text=String(element.total)
                cell.UILabelColorValue.text=element.color_value
                cell.UIImageViewColor.sd_setImage(with: URL(string: element.color_image), placeholderImage: UIImage(named: "placeholder_image"))
                cell.UIImageViewProduct.sd_setImage(with: URL(string: element.imageUrl), placeholderImage: UIImage(named: "placeholder_image"))

                self.viewmodel2.outputs.list_produt_attribute.subscribe{ (event1) in
                    print("hello change")
                    Observable.of(event1.element!).bind(to: cell.UICollectionViewAttributeNameValue.rx.items(cellIdentifier: "orderProductAttributeValueCell", cellType: orderProductAttributeValueCell.self)) { (row1, element1, cell1) in
                        //cell1.UILabelAttributeName.text = element1.name
                    }
                    .disposed(by: self.disposeBag1)
                }
                
                if row==2
                {
                  self.viewmodel2.list_produt_attribute.onNext(event.element![0].list_attribute_value)
                }
                
                
                }
            .disposed(by: self.disposeBag)
            
            
        }
        
        viewmodel.outputs.messageError.subscribe { (event) in
            
        }
        
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
                    
                    self.viewmodel.list_produt.onNext(orderModel.list_product)
                    
                    
                    
                    
                    
                    
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
        
        print("hello2")
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attributeCell", for: indexPath) as! attributeCell
        print("hello1")
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView==self.UICollectionViewOrderProducts){
            return CGSize(width: (UIScreen.main.bounds.width) / 1, height: 220.0)
        }else{
            return CGSize(width: (UIScreen.main.bounds.width) / 1, height: 100.0)
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
}

