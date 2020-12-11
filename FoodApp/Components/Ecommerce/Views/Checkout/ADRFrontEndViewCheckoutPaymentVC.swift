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
class paymentCell: UICollectionViewCell {
    
    @IBOutlet weak var UIImageViewPayment: UIImageView!
    @IBOutlet weak var UILabelPaymentName: UILabel!
}

class ADRFrontEndViewCheckoutPaymentVC: UIViewController {
    
    
    @IBOutlet weak var UICollectionViewPayments: UICollectionView!
    @IBOutlet weak var UIButtonNext: UIButton!
    @IBOutlet weak var UIButtonBack: UIButton!
    var payments:[PaymentModel]=[PaymentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlStringPayment = API_URL + "/api/payments/list"
        self.Webservice_getPayments(url: urlStringPayment, params: [:])
        
        
        
        
    }
    @IBAction func UIButtonTouchUpInsideNext(_ sender: UIButton) {
        
    }
    @IBAction func UIButtonTouchUpInsideBack(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ADRFrontEndViewCheckoutSummaryVC") as! ADRFrontEndViewCheckoutSummaryVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
}
extension ADRFrontEndViewCheckoutPaymentVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.payments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "paymentCell", for: indexPath) as! paymentCell
        let payment = self.payments[indexPath.row]
        cell.UILabelPaymentName.text! = payment.name
        cell.UIImageViewPayment.sd_setImage(with: URL(string: payment.default_photo.img_path), placeholderImage: UIImage(named: "placeholder_image"))
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width) / 3, height: 50.0)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
}

extension ADRFrontEndViewCheckoutPaymentVC
{
    
    func Webservice_getPayments(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPIResponseData(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:Data? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let getPaymentResponseModel = try jsonDecoder.decode(GetPaymentResponseModel.self, from: jsonResponse!)
                    self.payments=getPaymentResponseModel.payments
                    self.UICollectionViewPayments.delegate = self
                    self.UICollectionViewPayments.dataSource = self
                    self.UICollectionViewPayments.reloadData()
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
