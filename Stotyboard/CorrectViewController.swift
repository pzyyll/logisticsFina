//
//  CorrectViewController.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/19.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit
import SwiftyJSON

class CorrectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var orderDetail: OrderItem!
    var aler: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("correctCell", forIndexPath: indexPath) as! CorrectTableViewCell
        if self.orderDetail != nil {
            //cell.orderItem = self.orderDetail
            cell.setConfig(self.orderDetail)
        }
        return cell
    }

    @IBAction func correctAction(sender: UIButton) {
        let aler = UIAlertController(title: "-_-!", message: "确定确定，are you 确定????", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (act) -> Void in
            
            let user = NSUserDefaults.standardUserDefaults().valueForKey("user")
            let paras = ["user": user!, "order_num": self.orderDetail.orderID]
            GRNetWork.updateNewOrderHadRec(paras) { (_, _, data, err) -> Void in
                if err != nil {
                    self.showWarn()
                }
                let jsonData = JSON(data: data!)
                if jsonData["status"] == 1 {
                    self.showAlert({ (act) -> Void in
                        let viewCtrs = self.navigationController?.viewControllers
                        let rootCtr = viewCtrs![0] as! OrderViewController
                        rootCtr.loadNewOrderData()
                        rootCtr.loadingMyOrderData()
                        rootCtr.tabBarController?.tabBar.hidden = false
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    })

                } else {
                    self.showWarn()
                }
            }
            
         }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        aler.addAction(okAction)
        aler.addAction(cancelAction)
        self.presentViewController(aler, animated: true, completion: nil)
        
    }
    
    func showAlert(handler: (UIAlertAction) -> Void) {
        let alerView = UIAlertController(title: "", message: "您成功接单~尽快和商家联系哦！", preferredStyle: UIAlertControllerStyle.Alert)
        alerView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: handler))
        self.presentViewController(alerView, animated: true, completion: nil)
    }
    
    func showWarn() {
        self.aler = UILabel(frame: CGRectMake(0, 0, 180, 80))
        self.aler.center = CGPointMake(self.view.frame.width / 2, 250)
        self.aler.backgroundColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 0.8)
        self.aler.text = "网络连接失败~~"
        self.aler.textAlignment = .Center
        self.aler.font = UIFont.systemFontOfSize(10)
        self.aler.textColor = UIColor.whiteColor()
        self.aler.layer.cornerRadius = 2
        self.aler.layer.masksToBounds = true
        
        self.view.addSubview(self.aler)
        
        UIView.animateWithDuration(8, animations: { () -> Void in
            self.aler.alpha = 0.0
            }) { (finished) -> Void in
                self.aler.removeFromSuperview()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
