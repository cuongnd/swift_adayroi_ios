//
//  CartTableViewController.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/26/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    var cartManager: ShoppingCartManager? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("aaaaa")
        print(cartManager?.distinctProductCount())
        tableView.tableFooterView = UIView()
         self.tableView.reloadData()
    }
    @objc
    fileprivate func didSendAddToCartNotification(notification: Notification) {
        print("hrllo 3333")
        let product = notification.userInfo?["product"] as? Product;
        self.addProduct(product: product!)
       
        
    }
    func addProduct(product: Product) {
        print("product_id")
        self.cartManager?.addProduct(product: product)
        print("hello counter addProduct")
        print(cartManager?.distinctProductCount())
       
    }
    @objc
    fileprivate func didClearCartNotification(notification: Notification) {
        print("hello didClearCartNotification 123")
    }
    func didPlaceOrder() {
        // This is where you need to handle the placing of an order, based on the shopping cart configuration, accessible from cartMananger local var
        // The current implementation opens the Stripe View Controller and clears the products
        if cartManager?.distinctProductCount() ?? 0 > 0 {
            guard let price = cartManager?.totalPrice() else { return }
            let stripeSettingsVC = ATCStripeSettingsViewController()
            let stripeVC = ATCStripeCheckoutViewController(price: Int(price * 100), settings: stripeSettingsVC.settings)
            stripeVC.title = "Checkout"
            self.navigationController?.pushViewController(stripeVC, animated: true)
            cartManager?.clearProducts()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        
        guard let cartManager = cartManager else {
            return 0
        }
        print("hello counter tableView")
        print(cartManager.distinctProductCount() + 2)
        return cartManager.distinctProductCount() + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("couter")
        print(cartManager?.distinctProductCount())
        guard let cartManager = cartManager else {
            print("helllo 2")
            return UITableViewCell()
        }
        if (indexPath.row < cartManager.distinctProductCount()) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            print("helllo 3")
            cell.configureCell(item: cartManager.distinctProductItems()[indexPath.row])
            
            return cell
        } else if (indexPath.row == cartManager.distinctProductCount()) {
            print("helllo 4")
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTotalTableViewCell", for: indexPath) as! CartTotalTableViewCell
            cell.configureCell(total: cartManager.totalPrice())
            return cell
        }
        print("helllo 5")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartPlaceOrderTableViewCell", for: indexPath) as! CartPlaceOrderTableViewCell
        cell.configureCell(cartManager: cartManager)
        cell.delegate = self
        return cell
    }
    
    @objc
    fileprivate func didUpdateCart(notification: Notification) {
        print("hello didUpdateCart")
        tableView.reloadData()
    }
}



