//
//  RecOrderTableViewCell.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/19.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class RecOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var customBgView: UIView!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var sd_station: UILabel!
    @IBOutlet weak var order_status: UILabel!
    @IBOutlet weak var accept_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        
        self.customBgView.layer.shadowColor = UIColor.blackColor().CGColor
        self.customBgView.layer.shadowOffset = CGSizeMake(0, 0)
        self.customBgView.layer.shadowRadius = 2
        self.customBgView.layer.shadowOpacity = 0.24
        self.customBgView.layer.cornerRadius = 3
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item: MyOrderItem) {
        self.orderID.text = item.a_id
        self.sd_station.text = item.orderDetail.org_Station + " → " + item.orderDetail.des_Station
        switch item.status {
        case 0:
            self.order_status.text = "未配送"
            self.order_status.textColor = UIColor.greenColor()
        case 1:
            self.order_status.text = "配送中"
        case 2:
            self.order_status.text = "已送达"
        default:
            self.order_status.text = "已取消"
            self.order_status.textColor = UIColor.blackColor()
        }
        self.accept_time.text = item.acceptTime
    }
    
}
