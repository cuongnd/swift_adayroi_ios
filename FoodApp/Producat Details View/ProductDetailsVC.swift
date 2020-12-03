//
//  ProductDetailsVC.swift
//  FoodApp
//
//  Created by Mitesh's MAC on 04/06/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit
import ImageSlideshow
import WebKit
import SwiftyJSON
class AddonseCell: UITableViewCell {
    
    @IBOutlet weak var btn_Close: UIButton!
    @IBOutlet weak var btn_Check: UIButton!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    
}
class ProductDetailColorCell: UICollectionViewCell {

    @IBOutlet weak var colorImage: UIImageView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var btn_Check: UIButton!
}
class ProductDetailAttributesHeaderCell: UICollectionViewCell {
    
}

class IngredientsCell: UICollectionViewCell {
    
    @IBOutlet weak var cell_view: UIView!
    @IBOutlet weak var img_Ingredients: UIImageView!
}
class ProductDetailsVC: UIViewController,UITextViewDelegate,WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var text_view: UITextView!
    @IBOutlet weak var Addons_Height: NSLayoutConstraint!
    @IBOutlet weak var TableView_AddonsList: UITableView!
    
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var btn_Cart: UIButton!
    @IBOutlet weak var CollectionView_IngredientsList: UICollectionView!
    @IBOutlet weak var btn_Addtocart: UIButton!
    @IBOutlet weak var image_Slider: ImageSlideshow!
    
    @IBOutlet weak var lbl_itemsName: UILabel!
    @IBOutlet weak var lbl_CategoriesName: UILabel!
    @IBOutlet weak var lbl_itemsPrice: UILabel!
    @IBOutlet weak var lbl_itemsDescripation: UILabel!
    
    @IBOutlet weak var UICollectionViewColors: UICollectionView!
    @IBOutlet weak var UICollectionViewAttributesHeader: UICollectionView!
    @IBOutlet weak var lbl_itemTime: UILabel!
    
    @IBOutlet weak var lbl_IngredientsLavel: UILabel!
    @IBOutlet weak var lbl_DetailsLabel: UILabel!
    var itemsId = String()
    var itesmingredientsData = [JSON]()
    var colorsData = [JSON]()
    var attributes_header = [JSON]()
    var productImages = [SDWebImageSource]()
    var addonsArray = [[String:String]]()
    var SelectedAddons = [[String:String]]()
    var FinalTotal = Double()
    @IBOutlet weak var lbl_count: UILabel!
    @IBOutlet weak var btn_Minus: UIButton!
    @IBOutlet weak var btn_Pluse: UIButton!
    @IBOutlet weak var lbl_Cartcount: UILabel!
    @IBOutlet weak var item_UnavailableView: UIView!
    @IBOutlet weak var UnavailableView_Height: NSLayoutConstraint!
    
    @IBOutlet weak var productUnitPrice: UILabel!
    @IBOutlet weak var MainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var heightWebview: NSLayoutConstraint!
    @IBOutlet weak var DescriptionProduct: WKWebView!
    let cartStr = "Add To Cart".localiz()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.item_UnavailableView.isHidden = true
        self.lbl_DetailsLabel.text = "Details".localiz()
        self.lbl_IngredientsLavel.text = "Ingredients".localiz()
        self.btn_Addtocart.setTitle(cartStr, for: .normal)
        let urlString = API_URL + "/api/products/"+String(self.itemsId)
        let params: NSDictionary = [:]
        self.Webservice_getitemsDetails(url: urlString, params:params)
        cornerRadius(viewName: self.btn_Cart, radius: 8.0)
        cornerRadius(viewName: self.btn_back, radius: 8.0)
        cornerRadius(viewName: self.btn_Addtocart, radius: 6.0)
        cornerRadius(viewName: self.text_view, radius: 6.0)
        cornerRadius(viewName: self.lbl_Cartcount, radius: self.lbl_Cartcount.frame.height / 2)
        self.productImages.removeAll()
        let urlGetImagesString = API_URL + "/api/images/list/img_parent_id/"+String(self.itemsId)+"/img_type/product"
        
        let paramsGetImages: NSDictionary = [:]
        
        self.Webservice_getImageByProductDetail(url: urlGetImagesString, params:paramsGetImages)
        self.text_view.text = "Write Notes".localiz()
        self.text_view.textColor = UIColor.lightGray
        self.text_view.delegate = self
        self.lbl_count.text! = "1"
        self.DescriptionProduct.navigationDelegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let urlString = API_URL1 + "cartcount"
        let params: NSDictionary = ["user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId)]
        //self.Webservice_cartcount(url: urlString, params:params)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write Notes".localiz()
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func btnTap_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_AddtoCart(_ sender: UIButton) {
        if UserDefaultManager.getStringFromUserDefaults(key: UD_isSkip) == "1"
        {
            let storyBoard = UIStoryboard(name: "User", bundle: nil)
            let objVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let nav : UINavigationController = UINavigationController(rootViewController: objVC)
            nav.navigationBar.isHidden = true
            UIApplication.shared.windows[0].rootViewController = nav
        }
        else{
            if self.text_view.text == "Write Notes".localiz()
            {
                self.text_view.text = ""
            }
            
            var AddoncId = [String]()
            for data in self.SelectedAddons
            {
                AddoncId.append(data["id"]!)
            }
            
            let ItemPriceTotal = formatter.string(for: FinalTotal)
            let urlString = API_URL + "cart"
            let params: NSDictionary = ["item_id":self.itemsId,"qty":self.lbl_count.text!,"price":"\(ItemPriceTotal!)","user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),"addons_id":AddoncId.joined(separator: ","),"item_notes":self.text_view.text!]
            self.Webservice_AddtoCart(url: urlString, params:params)
        }
    }
    @IBAction func btnTap_Cart(_ sender: UIButton) {
        if UserDefaultManager.getStringFromUserDefaults(key:UD_isSkip) == "1"
        {
            let storyBoard = UIStoryboard(name: "User", bundle: nil)
            let objVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let nav : UINavigationController = UINavigationController(rootViewController: objVC)
            nav.navigationBar.isHidden = true
            UIApplication.shared.windows[0].rootViewController = nav
        }else{
            let vc = self.storyboard?.instantiateViewController(identifier: "AddtoCartVC") as! AddtoCartVC
            self.navigationController?.pushViewController(vc, animated:true)
        }
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("hello3434343")
        self.DescriptionProduct.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.DescriptionProduct.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    print("hello set height")
                    print(height!)
                    //self.DescriptionProduct.frame.size.height = 1
                    //self.DescriptionProduct.frame.size = self.DescriptionProduct.sizeThatFits(.zero)
                    //self.DescriptionProduct.scrollView.isScrollEnabled=false;
                    //myWebViewHeightConstraint.constant = self.DescriptionProduct.scrollView.contentSize.height
                    self.heightWebview?.constant = height as! CGFloat
                    print(height!)
                    self.MainViewHeight?.constant += height as! CGFloat
                    print(height!)
                    if((height as! Double)>10000){
                        //self.heightWebview?.constant = (height as! CGFloat)-10000
                        //self.MainViewHeight?.constant += (height as! CGFloat)-10000
                    }else{
                        //self.heightWebview?.constant = (height as! CGFloat)
                        //self.MainViewHeight?.constant += (height as! CGFloat)
                    }
                    // self.DescriptionProduct.frame = CGRect(x: 0, y: 0, width: self.DescriptionProduct.frame.width, height: self.DescriptionProduct.frame.height + 6000.0)
                    
                    //self.DescriptionProduct.frame.size.height = height as! CGFloat
                })
            }
            
        })
        
        
    }
    @IBAction func btnTap_AddOns(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddOnsVC") as! AddOnsVC
        vc.delegate = self
        vc.addonsArray = self.addonsArray
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnTap_Pluse(_ sender: UIButton) {
        let CountPluse  = AFWrapperClass.compareStringValue(currentValue:self.lbl_count.text!, limit: 99, toDo: .Add)
        print(CountPluse)
        self.lbl_count.text = CountPluse
        
        var Prices = [Double]()
        for data in self.SelectedAddons
        {
            Prices.append(Double("\(data["price"]!)")!)
        }
        print(Prices)
        let total = Prices.reduce(0, +)
        let SetTotal = self.productUnitPrice.text!.dropLast().replacingOccurrences(of: " ", with: "")
        let Total = Double(SetTotal)! + total
        let Qtyvalue = self.lbl_count.text!
        self.FinalTotal = ((Double(Qtyvalue)!) * Double(Total))
        print(FinalTotal)
        let ItemPriceTotal = formatter.string(for: FinalTotal)
        self.btn_Addtocart.setTitle("\(cartStr) \(ItemPriceTotal!) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))".localiz(), for: .normal)
        
    }
    @IBAction func btnTap_Minus(_ sender: UIButton) {
        let CountMinus  = AFWrapperClass.compareStringValue(currentValue:self.lbl_count.text!, limit: 99, toDo: .Subtract)
        self.lbl_count.text = CountMinus
        
        print(CountMinus)
        
        var Prices = [Double]()
        for data in self.SelectedAddons
        {
            Prices.append(Double("\(data["price"]!)")!)
            
        }
        print(Prices)
        let total = Prices.reduce(0, +)
        let SetTotal = self.lbl_itemsPrice.text!.dropLast().replacingOccurrences(of: " ", with: "")
        let Total = Double(SetTotal)! + total
        let Qtyvalue = self.lbl_count.text!
        self.FinalTotal = ((Double(Qtyvalue)!) * Double(Total))
        print(FinalTotal)
        let ItemPriceTotal = formatter.string(for: FinalTotal)
        self.btn_Addtocart.setTitle("\(cartStr) \(ItemPriceTotal!) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))".localiz(), for: .normal)
    }
}

extension ProductDetailsVC {
    func imageSliderData() {
        self.image_Slider.slideshowInterval = 3.0
        self.image_Slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 10.0))
        self.image_Slider.contentScaleMode = UIView.ContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.image_Slider.pageIndicator = pageControl
        self.image_Slider.setImageInputs(self.productImages)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImage))
        self.image_Slider.addGestureRecognizer(recognizer)
    }
    
    @objc func didTapImage() {
        self.image_Slider.presentFullScreenController(from: self)
    }
}
extension ProductDetailsVC: AddOnsDelegate {
    
    func refreshData(AddonsArray: [[String : String]]) {
        print(AddonsArray)
        self.SelectedAddons.removeAll()
        for data in AddonsArray
        {
            if data["isselected"]! == "1"
            {
                self.SelectedAddons.append(data)
            }
        }
        print(self.SelectedAddons)
        if SelectedAddons.count != 0
        {
            self.Addons_Height.constant = CGFloat(80 * self.SelectedAddons.count)
            self.MainViewHeight.constant+=CGFloat(80 * self.SelectedAddons.count)
            self.lbl_count.text = "1"
            let SetTotal = self.productUnitPrice.text!.dropLast().replacingOccurrences(of: " ", with: "")
            self.FinalTotal = Double(SetTotal)!
            let ItemPriceTotal = formatter.string(for: FinalTotal)
            self.btn_Addtocart.setTitle("\(cartStr) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPriceTotal!)".localiz(), for: .normal)
        }
        else{
            self.Addons_Height.constant = 80.0
            
            self.lbl_count.text = "1"
            let SetTotal = self.lbl_itemsPrice.text!.dropFirst().replacingOccurrences(of: " ", with: "")
            self.FinalTotal = Double(SetTotal)!
            let ItemPriceTotal = formatter.string(for: FinalTotal)
            self.btn_Addtocart.setTitle("\(cartStr) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPriceTotal!)".localiz(), for: .normal)
        }
        
        self.TableView_AddonsList.delegate = self
        self.TableView_AddonsList.dataSource = self
        self.TableView_AddonsList.reloadData()
        
        var Prices = [Double]()
        for data in self.SelectedAddons
        {
            Prices.append(Double("\(data["price"]!)")!)
        }
        print(Prices)
        let total = Prices.reduce(0, +)
        let SetTotal = self.productUnitPrice.text!.dropLast().replacingOccurrences(of: " ", with: "")
        let Total = Double(SetTotal)! + total
        let Qtyvalue = self.lbl_count.text!
        self.FinalTotal = ((Double(Qtyvalue)!) * Double(Total))
        let ItemPriceTotal = formatter.string(for: FinalTotal)
        self.btn_Addtocart.setTitle("\(cartStr) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPriceTotal!)".localiz(), for: .normal)
        
    }
    
}
extension ProductDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.CollectionView_IngredientsList{
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.CollectionView_IngredientsList.bounds.size.width, height: self.CollectionView_IngredientsList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            //messageLabel.font = UIFont(name: "POPPINS-REGULAR", size: 15)!
            messageLabel.sizeToFit()
            self.CollectionView_IngredientsList.backgroundView = messageLabel;
            if self.itesmingredientsData.count == 0 {
                messageLabel.text = "NO INGREDIENTS"
            }
            else {
                messageLabel.text = ""
            }
            return itesmingredientsData.count
        }else if (collectionView == self.UICollectionViewColors){
            return colorsData.count
        }else if(collectionView == self.UICollectionViewAttributesHeader){
            return attributes_header.count
        }else{
            return 0
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.CollectionView_IngredientsList{
            let cell = self.CollectionView_IngredientsList.dequeueReusableCell(withReuseIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
            cornerRadius(viewName: cell.cell_view, radius: 8.0)
            let data = self.itesmingredientsData[indexPath.item]
            let imgUrl  = data["img_url"].stringValue
            
            cell.img_Ingredients.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder_image"))
            
            return cell
        }else if (collectionView == self.UICollectionViewColors){
            let cell = self.UICollectionViewColors.dequeueReusableCell(withReuseIdentifier: "ProductDetailColorCell", for: indexPath) as! ProductDetailColorCell
            let data = self.colorsData[indexPath.item]
            let imgUrl  = data["img_url"].stringValue
            cell.colorName.text=data["value"].stringValue
            cell.colorImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder_image"))
            cell.btn_Check.tag = indexPath.row
            if data["isselected"] == "0"
            {
                cell.btn_Check.setImage(UIImage(systemName: "square"), for: .normal)
            }
            else{
                cell.btn_Check.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            }
            
            cell.btn_Check.addTarget(self, action: #selector(btnTap_Check), for: .touchUpInside)
            cell.colorName.tag = indexPath.row
            let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
            cell.colorName.isUserInteractionEnabled = true
            cell.colorName.addGestureRecognizer(tap)
            return cell
        }else if(collectionView == self.UICollectionViewAttributesHeader){
            let cell = self.UICollectionViewColors.dequeueReusableCell(withReuseIdentifier: "ProductDetailAttributesHeaderCell", for: indexPath) as! ProductDetailAttributesHeaderCell
            return cell
        }
        else{
            let cell = self.CollectionView_IngredientsList.dequeueReusableCell(withReuseIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.CollectionView_IngredientsList{
             return CGSize(width: (UIScreen.main.bounds.width - 20.0) / 3, height: 100.0)
        }else if (collectionView == self.UICollectionViewColors){
            return CGSize(width: UIScreen.main.bounds.width / 3, height: 155.0)
        }else if(collectionView == self.UICollectionViewAttributesHeader){
            return CGSize(width: UIScreen.main.bounds.width, height: 50)
        }else{
            return CGSize(width: (UIScreen.main.bounds.width - 20.0) / 3, height: 100.0)
        }
          
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.CollectionView_IngredientsList{
             
        }else if (collectionView == self.UICollectionViewColors){
            print("hello selected")
            let cell = self.UICollectionViewColors.dequeueReusableCell(withReuseIdentifier: "ProductDetailColorCell", for: indexPath) as! ProductDetailColorCell
            let data = self.colorsData[indexPath.item]
            let imgUrl  = "https://i1-vnexpress.vnecdn.net/2020/12/02/sinhviendeokhautrang-160688307-4039-1690-1606884365.jpg?w=680&h=408&q=100&dpr=1&fit=crop&s=gYIV3FE_BRxdo0i4OWiXWg"
            cell.colorName.text=data["value"].stringValue
            cell.colorImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder_image"))
        }else if(collectionView == self.UICollectionViewAttributesHeader){
            let cell = self.UICollectionViewColors.dequeueReusableCell(withReuseIdentifier: "ProductDetailColorCell", for: indexPath) as! ProductDetailColorCell
        }else{
            
        }
        
        
    }
    @objc func doubleTap(sender: UITapGestureRecognizer) {
        let current = self.colorsData[sender.view?.tag ?? 0]
        for index in 0...self.colorsData.count-1 {
           self.colorsData[index]["isselected"]="0"
        }
        for index in 0...self.colorsData.count-1 {
            
            if self.colorsData[index]["_id"]==current["_id"]{
                self.colorsData[index]["isselected"]="1"
            }
        }
        print("self.colorsData \(self.colorsData)")
        self.UICollectionViewColors.reloadData()
        
    }

    
   
    
    @objc func btnTap_Check(sender:UIButton)
    {
        let current = colorsData[sender.tag]
        for index in 0...self.colorsData.count-1 {
           self.colorsData[index]["isselected"]="0"
        }
        for index in 0...self.colorsData.count-1 {
            
            if self.colorsData[index]["_id"]==current["_id"]{
                self.colorsData[index]["isselected"]="1"
            }
        }
        print("self.colorsData \(self.colorsData)")
        self.UICollectionViewColors.reloadData()
        
    }
    
}
extension ProductDetailsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.TableView_AddonsList.bounds.size.width, height: self.TableView_AddonsList.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        //messageLabel.font = UIFont(name: "POPPINS-REGULAR", size: 15)!
        messageLabel.sizeToFit()
        self.TableView_AddonsList.backgroundView = messageLabel;
        if self.SelectedAddons.count == 0 {
            messageLabel.text = "NO ADD-ONS"
        }
        else {
            messageLabel.text = ""
        }
        return SelectedAddons.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TableView_AddonsList.dequeueReusableCell(withIdentifier: "AddonseCell") as! AddonseCell
        let data = self.SelectedAddons[indexPath.row]
        cell.lbl_Title.text = data["name"]!
        
        let ItemPrice = formatter.string(for: data["price"]!.toDouble)
        if ItemPrice == "0.00" ||  ItemPrice == "0.0" || ItemPrice == "0" || ItemPrice == ""
        {
            cell.lbl_Price.text = "Free"
        }
        else{
            cell.lbl_Price.text = "\(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPrice!)"
        }
        
        cell.btn_Close.tag = indexPath.row
        cell.btn_Close.addTarget(self, action: #selector(btnTap_Cose), for: .touchUpInside)
        return cell
        
    }
    @objc func btnTap_Cose(sender:UIButton)
    {
        self.SelectedAddons.remove(at: sender.tag)
        if SelectedAddons.count != 0
        {
            self.Addons_Height.constant = CGFloat(80 * self.SelectedAddons.count)
            self.MainViewHeight.constant-=80
            var Prices = [Double]()
            for data in self.SelectedAddons
            {
                Prices.append(Double("\(data["price"]!)")!)
            }
            print(Prices)
            let total = Prices.reduce(0, +)
            let SetTotal = self.productUnitPrice.text!.dropLast().replacingOccurrences(of: " ", with: "")
            let Total = Double(SetTotal)! + total
            let Qtyvalue = self.lbl_count.text!
            self.FinalTotal = ((Double(Qtyvalue)!) * Double(Total))
            let ItemPriceTotal = formatter.string(for: FinalTotal)
            self.btn_Addtocart.setTitle("\(cartStr) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPriceTotal!)".localiz(), for: .normal)
        }
        else
        {
            self.Addons_Height.constant = 80.0
            var Prices = [Double]()
            for data in self.SelectedAddons
            {
                Prices.append(Double("\(data["price"]!)")!)
            }
            print(Prices)
            let total = Prices.reduce(0, +)
            let SetTotal = self.productUnitPrice.text!.dropLast().replacingOccurrences(of: " ", with: "")
            let Total = Double(SetTotal)! + total
            let Qtyvalue = self.lbl_count.text!
            self.FinalTotal = ((Double(Qtyvalue)!) * Double(Total))
            let ItemPriceTotal = formatter.string(for: FinalTotal)
            self.btn_Addtocart.setTitle("\(cartStr) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPriceTotal!)".localiz(), for: .normal)
        }
        self.TableView_AddonsList.delegate = self
        self.TableView_AddonsList.dataSource = self
        self.TableView_AddonsList.reloadData()
    }
}
extension ProductDetailsVC
{
    func Webservice_getImageByProductDetail(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                let productImages = jsonResponse!.arrayValue
                self.productImages.removeAll()
                for image in productImages {
                    print(image["itemimage"].stringValue)
                    let imageSource = SDWebImageSource(url: URL(string: image["img_path"].stringValue)!, placeholder: UIImage(named: "placeholder_image"))
                    print(imageSource)
                    self.productImages.append(imageSource)
                }
                self.imageSliderData()
            }
        }
    }
    func Webservice_getitemsDetails(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["result"].stringValue
                if responseCode == "success" {
                    let itemsData = jsonResponse!["data"].dictionaryValue
                    
                    //let item_status = itemsData["item_status"]!.stringValue
                    let item_status="1"
                    if item_status == "2"
                    {
                        self.item_UnavailableView.isHidden = false
                        self.UnavailableView_Height.constant = 50.0
                    }
                    else{
                        self.item_UnavailableView.isHidden = true
                        
                    }
                    let currency=UserDefaultManager.getStringFromUserDefaults(key: UD_currency);
                    var original_price = formatter.string(for: itemsData["original_price"]!.stringValue.toDouble)
                    original_price="\(original_price!) \(currency)";
                    self.lbl_itemsPrice.attributedText = original_price?.strikeThrough()
                    
                    let unit_price = formatter.string(for: itemsData["unit_price"]!.stringValue.toDouble)
                    self.productUnitPrice.text = "\(unit_price!) \(currency)"
                    
                    let SetTotal = self.productUnitPrice.text!.dropLast().replacingOccurrences(of: " ", with: "")
                    //self.FinalTotal = Double(SetTotal)!
                    self.FinalTotal=itemsData["unit_price"]!.stringValue.toDouble;
                    let ItemPriceTotal = formatter.string(for: self.FinalTotal)
                    self.btn_Addtocart.setTitle("\(self.cartStr) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPriceTotal!)", for: .normal)
                    //self.lbl_itemsDescripation.text = itemsData["productDescription"]!.stringValue
                    let subcategory=itemsData["subcategory"]?.dictionaryValue;
                    self.lbl_CategoriesName.text = subcategory?["name"]!.stringValue
                    self.lbl_itemsName.text = itemsData["productTitle"]!.stringValue
                    //self.lbl_itemTime.text = itemsData["delivery_time"]!.stringValue
                    self.itesmingredientsData = itemsData["colors"]!.arrayValue
                    self.colorsData = itemsData["colors"]!.arrayValue
                    for index in 0...self.colorsData.count-1 {
                              self.colorsData[index]["isselected"]="0"
                           }
                    self.UICollectionViewColors.delegate = self
                    self.UICollectionViewColors.dataSource = self
                    self.UICollectionViewColors.reloadData()
                    self.attributes_header = itemsData["attributes_header"]!.arrayValue
                    self.UICollectionViewAttributesHeader.delegate = self
                    self.UICollectionViewAttributesHeader.dataSource = self
                    self.UICollectionViewAttributesHeader.reloadData()
                    
                    let datas = itemsData["colors"]!.arrayValue
                    for data in datas
                    {
                        let ItemPrice = formatter.string(for: data["price"].stringValue.toDouble)
                        let obj = ["price":ItemPrice!,"item_id":data["_id"].stringValue,"name":data["name"].stringValue,"id":data["id"].stringValue,"isselected":"1"]
                        self.addonsArray.append(obj)
                    }
                    print(self.addonsArray)
                    
                    self.CollectionView_IngredientsList.delegate = self
                    self.CollectionView_IngredientsList.dataSource = self
                    self.CollectionView_IngredientsList.reloadData()
                    // self.Addons_Height.constant = 80 * 1
                    _ = API_URL1 + "cartcount"
                    let _: NSDictionary = ["user_id":2]
                    //self.Webservice_cartcount(url: urlString, params:params)
                    let myURL = URL(string:"https://api.adayroi.online/api/products/description/"+itemsData["_id"]!.stringValue)
                    //let myURL=URL(string:"https://dantri.com.vn/xa-hoi/giao-thong-hon-loan-tai-nga-tu-dat-ham-chui-gan-700-ty-dong-o-ha-noi-20201102220649341.htm")
                    let myRequest = URLRequest(url: myURL!)
                    self.DescriptionProduct.load(myRequest)
                    
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        print("hell34334343");
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
    }
    func webViewDidFinishLoad(_ aWebView: UIWebView) {
        
        aWebView.scrollView.isScrollEnabled = false
        var frame = aWebView.frame
        
        frame.size.width = 200
        frame.size.height = 1
        
        aWebView.frame = frame
        frame.size.height = aWebView.scrollView.contentSize.height
        
        aWebView.frame = frame;
    }
    func Webservice_AddtoCart(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["status"].stringValue
                if responseCode == "1" {
                    let responceData = jsonResponse!["data"].dictionaryValue
                    
                    //                    let vc = self.storyboard?.instantiateViewController(identifier: "AddtoCartVC") as! AddtoCartVC
                    //                    self.navigationController?.pushViewController(vc, animated:true)
                    self.SelectedAddons.removeAll()
                    self.text_view.text = ""
                    self.TableView_AddonsList.reloadData()
                    self.Addons_Height.constant = 80.0
                    self.lbl_count.text = "1"
                    let SetTotal = self.lbl_itemsPrice.text!.dropFirst().replacingOccurrences(of: " ", with: "")
                    self.FinalTotal = Double(SetTotal)!
                    let ItemPriceTotal = formatter.string(for: self.FinalTotal)
                    self.btn_Addtocart.setTitle("\(self.cartStr) \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))\(ItemPriceTotal!)", for: .normal)
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                    let urlString = API_URL + "cartcount"
                    let params: NSDictionary = ["user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId)]
                    //self.Webservice_cartcount(url: urlString, params:params)
                }
                else {
                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    func Webservice_cartcount(url:String, params:NSDictionary) -> Void {
        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
            if strErrorMessage.count != 0 {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
            }
            else {
                print(jsonResponse!)
                let responseCode = jsonResponse!["status"].stringValue
                if responseCode == "1" {
                    self.lbl_Cartcount.isHidden = false
                    self.lbl_Cartcount.text = jsonResponse!["cart"].stringValue
                }
                else {
                    self.lbl_Cartcount.isHidden = false
                    self.lbl_Cartcount.text = "0"
                    //                        showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
                }
            }
        }
    }
    
}
enum mathFunction {
    /// When Addition is to done
    case Add
    /// When Subtraction is to be Done
    case Subtract
}

class AFWrapperClass : NSObject {
    //MARK: Fucntion used to comapre and update value
    /**
     This function is used to update stepper values
     - parameter currentValue : Current Value in Array
     - parameter limit : Maximum Value that can be used as stepper+1
     - parameter toDo : tells need to perform Add or subtract
     */
    class func compareStringValue(currentValue:String, limit:Int, toDo : mathFunction) -> String {
        var current : Int = Int(currentValue)!
        if (current <= limit) && (current >= 0) {
            if toDo == .Add {
                if current == limit {
                    return String(current)
                }
                else{
                    current += 1
                    return String(current)
                }
            }
            else {
                if current == 1 {
                    return String(current)
                }
                else {
                    current -= 1
                    return String(current)
                }
            }
        }
        else {
            return String(current)
        }
    }
}

