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
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "orderProductCell", bundle: nil)
        self.UICollectionViewOrderProducts.register(nib, forCellWithReuseIdentifier: "cell")
        
        self.viewmodel = ViewOrderControllerViewModel()
        viewmodel.outputs.list_produt.subscribe{ (event) in
            Observable.of(event.element!).bind(to: self.UICollectionViewOrderProducts.rx.items(cellIdentifier: "orderProductCell", cellType: orderProductCell.self)) { (row, element, cell) in
                cell.UILabelPrice.text=String(element.unit_price)
                cell.UILabelProductName.text=element.product_name
                cell.UILabelTotal.text=String(element.total)
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
