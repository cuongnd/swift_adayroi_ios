//
//  HomeViewController.swift
//  EcommerceApp
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDataSource,UIScrollViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topSlideshowCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var slideShowCollectionView: UICollectionView!
    var products = Product.mockProducts()
    var slideshowProducts = Product.mockProducts()
    var productsDiscount = Product.mockProducts()
    var newProducts = Product.mockProducts()
    var hotProducts = Product.mockProducts()
    var categories = Category.mockCategories()
    var hotProductCategories = Category.mockCategories()
    fileprivate let photos = [
        "Dakota Johnson",
        "Dakota Johnson",
        "Dakota Johnson",
        "Dakota Johnson",
        "Dakota Johnson"
    ]
    
    @IBOutlet weak var UICollectionViewSlideShow: UICollectionView!
    @IBOutlet weak var UICollectionViewNewProducts: UICollectionView!
    @IBOutlet weak var UICollectionViewHotProductCategories: UICollectionView!
    @IBOutlet weak var UICollectionViewProductDiscount: UICollectionView!
    @IBOutlet weak var UICollectionViewCategories: UICollectionView!
    @IBOutlet weak var UICollectionViewHotProducts: UICollectionView!
    var imgArr = [  UIImage(named:"Alexandra Daddario"),
                    UIImage(named:"Angelina Jolie") ,
                    UIImage(named:"Anne Hathaway") ,
                    UIImage(named:"Dakota Johnson") ,
                    UIImage(named:"Emma Stone") ,
                    UIImage(named:"Emma Watson") ,
                    UIImage(named:"Halle Berry") ,
                    UIImage(named:"Jennifer Lawrence") ,
                    UIImage(named:"Jessica Alba") ,
                    UIImage(named:"Scarlett Johansson") ]
    
    var currentIndex = 0
    var timer : Timer?
    @IBOutlet weak var pageView: UIPageControl!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UICollectionViewCategories.dataSource=self
        UICollectionViewProductDiscount.dataSource=self
        UICollectionViewHotProducts.dataSource=self
        UICollectionViewHotProductCategories.dataSource=self
        UICollectionViewNewProducts.dataSource=self
        UICollectionViewSlideShow.dataSource=self
        pageView.numberOfPages = slideshowProducts.count
        startTimer()
        // Do any additional setup after loading the view.
    }
    func get_slideshow_image() {
        let url = AppConfiguration.root_url+"api/products/?start=0&limit=20"
        let request = NSMutableURLRequest(url: URL(string: url)!)
        
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
            } else {
                if let content = data {
                    do {
                        //array
                        let my_json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        self.slideshowProducts=[Product]()
                        for current_product in my_json as! [[String: AnyObject]] {
                            var product: Product
                            print((current_product["default_photo"]!["img_path"])!);
                            product = Product(id: current_product["id"] as! String,name: current_product["productTitle"] as! String, imageUrl: current_product["default_photo"]!["img_path"] as! String,price: current_product["unit_price"] as! Double,description: "sdfds",category: "sdfds", images: ["https://cbu01.alicdn.com/img/ibank/2018/961/739/9144937169_1182200648.jpg"])
                            self.slideshowProducts.append(product);
                            
                        }
                        self.UICollectionViewSlideShow.reloadData()
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
    func DATA() {
        let url = AppConfiguration.root_url+"api/products/?start=0&limit=20"
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
                        print(self.products)
                        self.topSlideshowCollectionView?.reloadData()
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
    
    func startTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction(){
        
        let desiredScrollPosition = (currentIndex < slideshowProducts.count - 1) ? currentIndex + 1 : 0
        UICollectionViewSlideShow.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text="hello"
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width / 2
    }
}
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag==0)
        {
            return categories.count
        }else if(collectionView.tag==1){
            return productsDiscount.count
        }else if(collectionView.tag==2){
            return hotProducts.count
        }else if(collectionView.tag==3){
            return hotProductCategories.count
        }else if(collectionView.tag==4){
            return newProducts.count
        }else if(collectionView.tag==5){
            return slideshowProducts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell_0:CategoryCollectionViewCell!
        if(collectionView.tag==0)
        {
            cell_0 = UICollectionViewCategories.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! CategoryCollectionViewCell
            cell_0.configureCell(category: categories[indexPath.row])
            return cell_0
        }else if(collectionView.tag==1){
            let cell_1 = UICollectionViewProductDiscount.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ProductCollectionViewCell
            cell_1.show_discount_config_cell(product: productsDiscount[indexPath.row])
            return cell_1
        }else if(collectionView.tag==2){
            let cell_2 = UICollectionViewProductDiscount.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ProductCollectionViewCell
            cell_2.show_discount_config_cell(product: productsDiscount[indexPath.row])
            return cell_2
        }else if(collectionView.tag==3){
            let cell_3 = UICollectionViewHotProductCategories.dequeueReusableCell(withReuseIdentifier:"cell_hot_category", for: indexPath) as! CategoryCollectionViewCell
            cell_3.configureCell(category: hotProductCategories[indexPath.row])
            return cell_3
        }else if(collectionView.tag==4){
            let cell_4 = UICollectionViewNewProducts.dequeueReusableCell(withReuseIdentifier:"cell_new_products", for: indexPath) as! ProductCollectionViewCell
            cell_4.configureCell(product: newProducts[indexPath.row])
            return cell_4
        }else if(collectionView.tag==5){
            print("hello view cell 5")
            let cell_5 = UICollectionViewSlideShow.dequeueReusableCell(withReuseIdentifier:"cell_slideshow", for: indexPath) as! SlideShowCollectionViewCell
            cell_5.configureCell(product: slideshowProducts[indexPath.row])
            return cell_5
        }
        
       
        return cell_0
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = topSlideshowCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        currentIndex = Int(scrollView.contentOffset.x / UICollectionViewSlideShow.frame.size.width)
        pageView.currentPage = currentIndex
    }
}

