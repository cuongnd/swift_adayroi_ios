//
//  HomeHeader.swift
//  FoodApp
//
//  Created by MAC OSX on 11/22/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//

import UIKit

class HomeHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame:frame)
        commitInit();
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commitInit()
    }
    func commitInit(){
        let viewHomeTitle=Bundle.main.loadNibNamed("HomeHeader", owner: self, options: nil)![0] as! UIView
        addSubview(viewHomeTitle)
    }

}
