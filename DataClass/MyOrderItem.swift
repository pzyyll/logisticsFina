//
//  MyOrderItem.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/20.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyOrderItem {
    var orderDetail: OrderItem!
    var acceptTime: String!
    var status: Int!
    init () {
        self.orderDetail = OrderItem()
        self.acceptTime = ""
        self.status = 0
    }
    
    func setDate(item: JSON) {
        self.orderDetail.setData(item)
        self.acceptTime = item["accept_time"].string
        if item["a_status"] != nil {
            self.status = Int(item["a_status"].string!)
        }
    }
}