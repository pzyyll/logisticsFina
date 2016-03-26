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
    var start_distrubution: String!
    var end_distrubution: String!
    var status: Int!
    var a_id: String!
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
        self.start_distrubution = item["start_distrubution"].string ?? nil
        self.end_distrubution = item["end_distrubution"].string ?? nil
        self.a_id = item["a_id"].string ?? nil
    }
}