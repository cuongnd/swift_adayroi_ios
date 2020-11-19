//
//  OrdersViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/29/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class OrdersViewController: LibMvcViewController {
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var list_order=[Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.rest_api_get_orders()
        UITableViewOrders.dataSource=self
        UITableViewOrders.delegate=self
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        
        
    }
    @IBOutlet weak var UITableViewOrders: UITableView!
    func rest_api_get_orders() {
        let url = AppConfiguration.root_url+"api/orders/"
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            } else {
                if let content = data {
                    DispatchQueue.main.async {
                        do {
                            //array
                            let data_order_json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            self.list_order=[Order]()
                            for current_order in data_order_json  as! [[String: AnyObject]]  {
                                var order: Order
                                order = Order(_id:current_order["_id"] as! String,order_number:current_order["order_number"] as! String,total:current_order["total"] as! Double)
                                self.list_order.append(order);
                                
                            }
                           
                            self.UITableViewOrders.reloadData()
                            self.activityIndicator.stopAnimating()
                             UIApplication.shared.endIgnoringInteractionEvents()
                           
                        } catch {
                            print("load error my orders")
                        }
                    }
                }
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
                print("réponse = \(String(describing: response))") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
            }
            
            
            if error == nil {
                // Ce que vous voulez faire.
            }
        }
        requestAPI.resume()
        
        
    }
    func view_order_detail( sender: UIButton,order:Order) {
        print("order detail")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "handler_order_id"), object: nil, userInfo: ["order_id": order._id ])
        let order_detail = StoryboardEntityProvider().get_view_and_layout(view: "Order", controller: "Order")
        order_detail.perform(#selector(OrderViewController.test(order_id:)), with:(order._id) , afterDelay: 0.5)

        self.navigationController?.pushViewController(order_detail, animated: true)
        

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension OrdersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row_order", for: indexPath) as! OrderTableViewCell
        cell.configureCell(order: list_order[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}
extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

