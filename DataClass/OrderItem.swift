//
//  OrderItem.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/14.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class OrderItem {
    var orderID: String!
    var goodsType: String!
    var publisher: String!
    var des_Station: String!
    var org_Station: String!
    var time_range = 0
    var T_range: String!
    var loads: Int!
    var sender: String!
    var remark = ""
    var title: String!
    var content = ""
    var phone_num: String!
    var contacts: String!
    var status = 0
    var createDate: String!
    var img = ""
    
    init() {
        self.orderID = ""
        self.goodsType = ""
        self.publisher = ""
        self.des_Station = ""
        self.org_Station = ""
        self.time_range = 0
        self.T_range = ""
        self.loads = 0
        self.sender = ""
        self.remark = ""
        self.title = ""
        self.content = ""
        self.phone_num = ""
        self.contacts = ""
        self.createDate = ""
        self.img = ""
    }
    
    class func getTRStrFromNum(val: Int) -> String {
        var str = "";
        switch val {
        case 1:
            str = "-5℃~-2℃"
        case 2:
            str = "-2℃~0℃"
        case 3:
            str = "-0℃~2℃"
        case 4:
            str = "2℃~4℃"
        case 5:
            str = "4℃~6℃"
        case 6:
            str = "6℃~10℃"
        case 7:
            str = "10℃~15℃"
        case 8:
            str = "常温"
        default:
            break
        }
        return str
    }
    
    func setData(item: JSON) {
        self.title = item["title"].string
        self.content = item["content"].string!
        self.contacts = item["contacts"].string
        self.createDate = item["createTime"].string
        self.des_Station = item["destination_station"].string
        self.goodsType = item["type_name"].string
        //aOrder.img =
        self.loads = item["deliverd_quantity"].intValue
        self.orderID = item["order_num"].string
        self.org_Station = item["starting_station"].string
        self.phone_num = item["phone_num"].string
        self.publisher = item["name"].string
        if item["remark"].string != nil {
            self.remark = item["remark"].string!
        }
        self.sender = item["sender"].string
        self.status = item["status"].intValue
        self.T_range = OrderItem.getTRStrFromNum(item["T_range"].intValue)
        self.time_range = item["time_range"].intValue
    }
    
}