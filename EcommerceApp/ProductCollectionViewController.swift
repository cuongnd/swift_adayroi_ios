//
//  ProductCollectionViewController.swift
//  EcommerceApp
//
//  Created by Florian Marcu on 1/21/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Material
import UIKit
private let reuseIdentifier = "ProductCollectionViewCell"

class ProductCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var products = [Product]();
     var sub_category:Subcategory?
    var data1 = [[String: AnyObject]]()
    var page: Int = 0
    var isPageRefreshing:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.DATA(page1: 0)
    }

    func DATA(page1: Int) {
        let mypage = String(page1*20)
        let url = AppConfiguration.root_url+"api/products/?start="+mypage+"&limit=20"
        let request = NSMutableURLRequest(url: URL(string: url)!)

        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            } else {
                if let content = data {
                    do {
                        //array
                        let my_json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject

                        for current_product in my_json as! [[String: AnyObject]] {
                            var product: Product
                            print((current_product["default_photo"]!["img_path"])!);
                            product = Product(id: current_product["id"] as! String,name: current_product["productTitle"] as! String, imageUrl: current_product["default_photo"]!["img_path"] as! String,price: current_product["unit_price"] as! Double,description: "sdfds",category: "sdfds", images: ["https://cbu01.alicdn.com/img/ibank/2018/961/739/9144937169_1182200648.jpg"])
                            self.products.append(product);

                        }
                        self.isPageRefreshing=false
                        self.collectionView?.reloadData()
                    } catch {

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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.configureCell1(product: products[indexPath.row])
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumCellSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing = minimumCellSpacing()
        return UIEdgeInsetsMake(5, spacing, 5, spacing)
    }


    fileprivate func minimumCellSpacing() -> CGFloat {// The cell's size is 142 x 216
        let width = self.collectionView!.frame.size.width - 5
        let cellsPerRow = CGFloat(Int(width / 142.0))
        return (width - cellsPerRow * 142) / (cellsPerRow + 1)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if((self.collectionView?.contentOffset.y)! >= ((self.collectionView?.contentSize.height)! - (self.collectionView?.bounds.size.height)!)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                print(page)
                page = page + 1
                DATA(page1: page)
            }
        }
    }

}
