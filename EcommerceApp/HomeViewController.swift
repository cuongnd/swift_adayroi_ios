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
    
    var timer = Timer()
    var counter = 0
    @IBOutlet weak var pageView: UIPageControl!
    
    
    
    
    var slides:[Slide] = [];
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UICollectionViewCategories.dataSource=self
        UICollectionViewProductDiscount.dataSource=self
        UICollectionViewHotProducts.dataSource=self
        UICollectionViewHotProductCategories.dataSource=self
        UICollectionViewNewProducts.dataSource=self
        
        
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        
        
        
        // Do any additional setup after loading the view.
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
    
    
    
    
    @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.topSlideshowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.topSlideshowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
        
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
    
    
    func createSlides() -> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
        slide1.labelTitle.text = "A real-life bear"
        slide1.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "ic_onboarding_2")
        slide2.labelTitle.text = "A real-life bear"
        slide2.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "ic_onboarding_3")
        slide3.labelTitle.text = "A real-life bear"
        slide3.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "ic_onboarding_4")
        slide4.labelTitle.text = "A real-life bear"
        slide4.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "ic_onboarding_5")
        slide5.labelTitle.text = "A real-life bear"
        slide5.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
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
        }
        else if(collectionView.tag==4){
            return newProducts.count
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
        }else if(collectionView.tag==3){
            let cell_3 = UICollectionViewNewProducts.dequeueReusableCell(withReuseIdentifier:"cell_new_products", for: indexPath) as! ProductCollectionViewCell
            cell_3.configureCell(product: newProducts[indexPath.row])
            return cell_3
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
}

