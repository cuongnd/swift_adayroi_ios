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


class ADRFrontEndViewCheckoutPaymentVC: UIViewController {
    
    
    @IBOutlet weak var UIButtonNext: UIButton!
       @IBOutlet weak var UIButtonBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        
    }
    @IBAction func UIButtonTouchUpInsideNext(_ sender: UIButton) {
    }
    @IBAction func UIButtonTouchUpInsideBack(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ADRFrontEndViewCheckoutVC") as! ADRFrontEndViewCheckoutVC
        self.navigationController?.pushViewController(vc, animated:true)
    }
}
