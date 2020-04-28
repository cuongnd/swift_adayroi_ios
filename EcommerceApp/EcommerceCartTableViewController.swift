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
    @IBOutlet var UITableViewListProductOrder: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
         self.tableView.reloadData()
    }
    @objc
    fileprivate func didSendAddToCartNotification(notification: Notification) {
        let product = notification.userInfo?["product"] as? Product;
        self.addProduct(product: product!)
       
        
    }
    func addProduct(product: Product) {
        self.cartManager?.addProduct(product: product)
       
    }
    @objc
    fileprivate func didClearCartNotification(notification: Notification) {
    }
    func didPlaceOrder() {
        let addressCheckoutViewControllerVC = StoryboardEntityProvider().AddressCheckoutViewControllerVC()
        self.navigationController?.pushViewController(addressCheckoutViewControllerVC, animated: true)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        
        guard let cartManager = cartManager else {
            return 0
        }
        return cartManager.distinctProductCount() + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartManager = cartManager else {
            return UITableViewCell()
        }
        if (indexPath.row < cartManager.distinctProductCount()) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            cell.configureCell(item: cartManager.distinctProductItems()[indexPath.row])
            return cell
        } else if (indexPath.row == cartManager.distinctProductCount()) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTotalTableViewCell", for: indexPath) as! CartTotalTableViewCell
            cell.configureCell(total: cartManager.totalPrice())
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartPlaceOrderTableViewCell", for: indexPath) as! CartPlaceOrderTableViewCell
        cell.configureCell(cartManager: cartManager)
        cell.delegate = self
        return cell
    }
    @objc func delete_product_in_cart(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: UITableViewListProductOrder)
        guard let indexPath = UITableViewListProductOrder.indexPathForRow(at: point) else {
            return
        }
        UITableViewListProductOrder.deleteRows(at: [indexPath], with: .left)
    }
    @objc
    fileprivate func didUpdateCart(notification: Notification) {
        UITableViewListProductOrder.reloadData()
    }
   
}



