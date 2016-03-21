//
//  MyRecOrderTableView.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/19.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

protocol MyRecOrderTableViewDataSource {
    func MyRecOrderTableView(numOfOrderLib num: Int) -> Int
    func MyRecOrderTableView(dataForRow row: Int) -> MyOrderItem?
}

class MyOrderTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var myOrderLib = MyOrderLibrary()
    
    var controllerDelegate: ControllerDelegate!
    
    var dataDelegate: MyRecOrderTableViewDataSource!
    var ctrDelegate: ControllerDelegate!
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return myOrderLib.myOrderItems.count
    }
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "recOrder"
        tableView.rowHeight = 140
        tableView.registerNib(UINib(nibName: "RecOrderTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! RecOrderTableViewCell
        cell.setData(self.myOrderLib.myOrderItems[indexPath.section])
        return cell
    }

    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != self.myOrderLib.myOrderItems.count - 1 {
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
    
    func sortDate(m1: MyOrderItem, m2: MyOrderItem) -> Bool {
        let formDate = NSDateFormatter()
        formDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = formDate.dateFromString(m1.acceptTime)
        let date2 = formDate.dateFromString(m2.acceptTime)
        
        return date1?.timeIntervalSince1970 > date2?.timeIntervalSince1970
    }
    
    override func reloadData() {
        var count = 0
        self.myOrderLib.myOrderItems.removeAll()
        if self.dataDelegate != nil {
            count = self.dataDelegate.MyRecOrderTableView(numOfOrderLib: 0)
            if count > 0 {
                for i in 0..<count {
                    let item = self.dataDelegate.MyRecOrderTableView(dataForRow: i)
                    self.myOrderLib.myOrderItems.append(item!)
                }
                self.myOrderLib.myOrderItems.sortInPlace(sortDate)
            }
        }
        super.reloadData()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let ctr = storyboard.instantiateViewControllerWithIdentifier("myOrderDetail") as! MyOrderDetailViewController
        ctr.myOrderDetailItem = self.myOrderLib.myOrderItems[indexPath.section]
        self.ctrDelegate.getViewCtr()?.navigationController?.pushViewController(ctr, animated: true)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
