//
//  SubCategoriesViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class SubCategoriesViewController: UIViewController {
    var category:Category?
    var reuseIdentifier:String=""
    var sub_category=[Subcategory]()
    @IBOutlet var UITableViewSubCategory: UITableView!
     var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
   override func viewDidLoad() {
        super.viewDidLoad()
    
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    
        UITableViewSubCategory.dataSource=self
        UITableViewSubCategory.delegate=self
        self.rest_api_get_sub_category()
    }
    
    func rest_api_get_sub_category() {
        let url = AppConfiguration.root_url+"api/subcategories/?start=0&limit=20&filter_cat_id="+category!.id
        let request = NSMutableURLRequest(url: URL(string: url)!)
        print("now start load categories data")
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            } else {
                if let content = data {
                    DispatchQueue.main.async {
                        do {
                            //array
                            let my_json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            self.sub_category=[Subcategory]()
                            for current_category in my_json as! [[String: AnyObject]] {
                                var sub_category: Subcategory
                                sub_category = Subcategory(id: current_category["id"] as! String,name: current_category["name"] as! String)
                                self.sub_category.append(sub_category);
                                
                            }
                            print("response categories")
                            print(self.sub_category)
                            self.UITableViewSubCategory.reloadData()
                            self.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                        } catch {
                            print("load error slideshow")
                        }
                    }
                }
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
                print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
            }
            
            
            if error == nil {
                // Ce que vous voulez faire.
            }
        }
        requestAPI.resume()
        
        
    }
    
}
extension SubCategoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sub_category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row_sub_category", for: indexPath) as! SubCategoryTableViewCell
        cell.configureCell(sub_category: sub_category[indexPath.row])
        return cell
    }
  
}
extension SubCategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var productsVC = StoryboardEntityProvider().ecommerceProductCollectionVC()
        productsVC.sub_category = sub_category[indexPath.row]
        productsVC.page=0
        productsVC.products=[Product]()
        productsVC.isPageRefreshing=true
        self.navigationController?.pushViewController(productsVC, animated: true)
    }
}


