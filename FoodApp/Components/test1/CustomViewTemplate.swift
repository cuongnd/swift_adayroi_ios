//
//  CustomViewTemplate.swift
//  APSMSwift
//
//  Created by Yume on 2014/8/3.
//  Copyright (c) 2014年 yume. All rights reserved.
//

import UIKit

protocol CustomViewTemplateProtocol{
    func setup()
    func viewLiveRendering()
    
    func processViewSource()
    func processFuture()
    
    func className() -> String
}

protocol CustomViewProtocol:CustomViewTemplateProtocol{
    func instantiateWithXib()
    func bundleIdentifier() -> String
    func frameworkBundle() -> Bundle
}

@IBDesignable
class CustomViewTemplate: UIView ,CustomViewTemplateProtocol{
    
    @IBInspectable var viewSourceKeyPath:String?
    @IBInspectable var viewSourceDictionary:NSDictionary?
    
    @IBInspectable var borderLineWidth: CGFloat = 0 {
        willSet{
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderRadius: CGFloat = 0 {
        willSet{
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        willSet{
            layer.borderColor = newValue.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder : NSCoder) {
        super.init(coder:coder)
        setup()
    }
    
    func setup() {}
    
    override func prepareForInterfaceBuilder() {
        self.viewLiveRendering()
    }
    
    override func draw(_ rect: CGRect) {
        self.viewLiveRendering()
    }
    
    func viewLiveRendering() {
        
    }
    
    func processViewSource() {}
    func processFuture() {}
    
    func instantiateWithXib(){
        
        let bundle:Bundle = frameworkBundle()
        
        let nib:UINib = UINib(nibName: className(), bundle: bundle)
        
        nib.instantiate(withOwner: self, options: nil)
    }
    
    func frameworkBundle() -> Bundle{
        return Bundle(identifier: bundleIdentifier())!
    }
    
    func bundleIdentifier() -> String{
        //Bundle Identifier can be find at Target -> Your Framework -> Bundle Identifier
        return "com.yume190.CustomViewSwift"
    }
    
    func className() -> String{
        return ""
    }
}
