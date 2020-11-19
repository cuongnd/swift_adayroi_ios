//
//  checkout_steps.swift
//  EcommerceApp
//
//  Created by Macbook on 5/1/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

@IBDesignable class checkout_steps: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame:frame)
        loadViewFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        let _=loadViewFromNib()
    }
    
    func loadViewFromNib()->UIView{
        let bundle=Bundle.init(for:type(of: self))
        let view = UINib(
            nibName: "checkout_steps",
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
        view?.frame=bounds
        view?.autoresizingMask=[UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        addSubview(view!)
        return view!
        
        
        
    }

}
