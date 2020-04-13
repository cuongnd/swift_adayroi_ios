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
   override func viewDidLoad() {
        super.viewDidLoad()
    UITableViewSubCategory.dataSource=self
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
                    } catch {
                        print("load error slideshow")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width / 2
    }
    
    
    
   
    
    
}



