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
    var _id_need_delete:String=""
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
        print("cartManager.distinctProductCount()")
        print(cartManager.distinctProductCount())
        return cartManager.distinctProductCount() + 2
    }
   
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartManager = cartManager else {
            return UITableViewCell()
        }
        if (indexPath.row < cartManager.distinctProductCount()) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            cell.configureCell(item: cartManager.distinctProductItems()[indexPath.row])
            cell.delegate = self
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
    func delete_product_in_cart( sender: UIButton,item:ShoppingCartItem) {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn có chắc chắn muốn xóa sản phẩm khỏi giỏ hàng", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Chắc chắn", style: .default, handler: self.handleDeleteProductNow))
        alert.addAction(UIAlertAction(title: "huyr", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        _id_need_delete=item.product._id
    }
    func handleDeleteProductNow(alert: UIAlertAction!){
        cartManager?.removeProduct(_id:_id_need_delete)
        cartManager=ShoppingCartManager()
        self.tableView.reloadData()
    }
    @objc
     func didUpdateCart(notification: Notification) {
        UITableViewListProductOrder.reloadData()
    }
   
}



