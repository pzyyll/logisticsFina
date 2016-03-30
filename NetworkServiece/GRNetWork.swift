//
//  GRNetWork.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/15.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let urlHead1 = "http://www.ooly.club/ios/exam/interface"
let urlHead2 = "http://localhost/logistics/interface"
let urlHead = urlHead1
let urlLogin = "\(urlHead)/login.php"                 //登录
let urlAllOrder = "\(urlHead)/allOrderData.php"       //获取全部的最新订单信息
let urlUpdateRec = "\(urlHead)/addOrderHadRec.php"    //更新我的接单信息
let urlAllMyOrder = "\(urlHead)/allMyOrderData.php"   //获取我的全部订单信息
let urlOneMyOrder = "\(urlHead)/getMyOrderDataByOrderID.php" //获取我的订单的单个订单信息
let urlUpdateMyOrder = "\(urlHead)/updateOrderStatus.php"

class GRNetWork {
    class func getAllOrderData(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Void) {
        Alamofire.request(.GET, urlAllOrder).response(completionHandler: completionHandler)
    }
    
    class func loginRequest(parameters: [String : AnyObject]?, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Void) {
        Alamofire.request(.POST, urlLogin, parameters: parameters).response(completionHandler: completionHandler)
    }
    
    class func updateNewOrderHadRec(parameters: [String: AnyObject]?, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Void) {
        Alamofire.request(.POST, urlUpdateRec, parameters: parameters).response(completionHandler: completionHandler)
    }
}

extension GRNetWork {
    class func getMyAllOrderData(parameters: [String: AnyObject]?, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Void) {
        Alamofire.request(.GET, urlAllMyOrder, parameters: parameters).response(completionHandler: completionHandler)
    }
    
    class func getOneMyOrderDataByOrderID(parameters: [String: AnyObject]?, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Void) {
        Alamofire.request(.GET, urlOneMyOrder, parameters: parameters).response(completionHandler: completionHandler)
    }
}

extension GRNetWork {
    class func updateMyOrder(parameters: [String: AnyObject]?, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> Void) {
        Alamofire.request(.POST, urlUpdateMyOrder, parameters: parameters).response(completionHandler: completionHandler)
    }
}
