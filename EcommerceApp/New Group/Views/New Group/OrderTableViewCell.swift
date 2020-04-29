//
//  OrderTableViewCell.swift
//  EcommerceApp
//
//  Created by Macbook on 4/29/20.
//  Copyright © 2020 iOS App Templates. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var UIButtonViewDetail: UIButton!
    @IBOutlet weak var UILabelOrderStatus: UILabel!
    @IBOutlet weak var UILabelTotal: UILabel!
    @IBOutlet weak var UILabelVendorName: UILabel!
    @IBOutlet weak var UILabelOderNUmber: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     func configureCell(order: Order) {
        self.isUserInteractionEnabled = true
        let total = order.total! as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "vi_VN") // This is the default
        // In Swift 4, this ^ has been renamed to simply NSLocale.current
        UILabelTotal.text = formatter.string(from: total)
        UILabelOderNUmber.text=order.order_number
        
    }

}
