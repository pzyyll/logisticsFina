//
//  NewOrderTableView.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/14.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

protocol NewOrderTableViewDataSource {
    func newOrderTableView(tableView: NewOrderTableView, numOfOrderLib num: Int) -> Int
    func newOrderTableView(tableView: NewOrderTableView, dataForRow row: Int) -> OrderItem?
}

protocol ControllerDelegate {
    func getViewCtr() -> UIViewController?
}

class NewOrderTableView: UITableView, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    //保存订单数据
    var orderLib = OrderLibrary()
    
    var dataSourceOfOrder: NewOrderTableViewDataSource!
    var controllerDelegate: ControllerDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .None
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    func sortDate(m1: OrderItem, m2: OrderItem) -> Bool {
        let formDate = NSDateFormatter()
        formDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = formDate.dateFromString(m1.createDate)
        let date2 = formDate.dateFromString(m2.createDate)
        
        return date1?.timeIntervalSince1970 > date2?.timeIntervalSince1970
    }

    override func reloadData() {
        var count = 0
        orderLib.OrderItems.removeAll()
        if self.dataSourceOfOrder != nil {
            count = self.dataSourceOfOrder.newOrderTableView(self, numOfOrderLib: 0)
            if count > 0 {
                for i in 0..<count {
                    let item = self.dataSourceOfOrder.newOrderTableView(self, dataForRow: i)
                    orderLib.OrderItems.append(item!)
                }
                orderLib.OrderItems.sortInPlace(sortDate)
            }
        }
        super.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.orderLib.OrderItems.count
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != self.orderLib.OrderItems.count - 1 {
            return 10
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: self.frame)
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: self.frame)
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "id1"
        tableView.rowHeight = 161
        tableView.registerNib(UINib(nibName: "NewOrderTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! NewOrderTableViewCell
        
        if cell.detailLabels.count != 0 {
            for view in cell.detailLabels {
                view.removeFromSuperview()
            }
            cell.detailLabels.removeAll()
        }
        
        cell.setConfig(self.orderLib.OrderItems[indexPath.section])
        cell.backgroundView = nil
        cell.phoneBtn.tag = indexPath.section
        cell.phoneBtn.addTarget(self, action: Selector("phoneAction:"), forControlEvents: .TouchUpInside)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newViewCtr = OrderDetailViewController()
        newViewCtr.orderDetail = self.orderLib.OrderItems[indexPath.section]
        self.controllerDelegate.getViewCtr()!.navigationController?.pushViewController(newViewCtr, animated: true)
        
        self.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func phoneAction(btn: UIButton) {
        print(btn.tag)
        print(orderLib.OrderItems[btn.tag].phone_num)
    }
    
    
//    - (UIViewController*)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//    UIResponder* nextResponder = [next nextResponder];
//    if ([nextResponder isKindOfClass:[UIViewController class]]) {
//    return (UIViewController*)nextResponder;
//    }
//    }
//    return nil;
//    }
//    func getViewCtr() -> UIViewController? {
//        var responder = self as? UIResponder
//        while responder != nil {
//            if ((responder?.isKindOfClass(UIViewController)) != nil) {
//                return responder! as? UIViewController
//            }
//            responder = responder?.nextResponder()
//        }
//        return nil
//    }
    func scrollViewDidScroll(scrollView: UIScrollView) {

        print(scrollView.contentOffset)
        print(scrollView.contentSize)
        print(scrollView.frame)
        print(self.contentSize.height - self.frame.height)
        
        //let contentMaxOffset = self.contentSize.height - self.frame.height
        
    }
    
}
