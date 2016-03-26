//
//  MyOrderDetailViewController.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/20.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class MyOrderDetailViewController: UIViewController, MyOrderTableViewDataSource {


    var myOrderDetailItem: MyOrderItem!
    var dataItems: [[String: String]]!
   
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var correctBtn2: UIButton!
    
    var tableView: MyOrderDetailTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataItems = [[String: String]]()
        self.viewConfig()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        switch self.myOrderDetailItem.status {
        case 0:
            self.correctBtn2.setTitle("开始配送", forState: .Normal)
        case 1:
            self.correctBtn2.setTitle("确认送达", forState: .Normal)
        default:
            self.bottomView.removeFromSuperview()
        }
        
        self.loadingData()
        self.setDataItem()
        self.tableView.reloadData()
        self.tableView.setStatus(self.myOrderDetailItem.status)
    }
    
    func viewConfig() {
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationController?.navigationBar.hideBottomHairline()
        
        //back btn
        self.tabBarController?.tabBar.hidden = true
        let img = UIImage(named: "Arrow_Back_72px")
        let backBtnItem = UIBarButtonItem(image: UIImage(data: UIImagePNGRepresentation(img!)!, scale: 2.8), style: .Plain, target: self, action: Selector("back"))
        backBtnItem.tintColor = UIColor.whiteColor()
        backBtnItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        self.navigationItem.leftBarButtonItem = backBtnItem

        self.correctBtn2.setTitle("开始配送", forState: .Normal)
        
        
        self.tableView = MyOrderDetailTableView(frame: self.view.frame, style: .Plain)
        self.tableView.frame.size.height -= (50 + 64)
        self.tableView.dateDelegate = self
        self.view.addSubview(self.tableView)
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func MyOrderTableView(numOfData num: Int) -> Int {
        return self.dataItems.count
    }
    func MyOrderTableView(dataForRow row: Int) -> AnyObject? {
        return self.dataItems[row]
    }
    
    func loadingData() {
        let paras = ["user": NSUserDefaults.standardUserDefaults().stringForKey("user")!,
            "a_id": self.myOrderDetailItem.a_id!
        ]
        print(paras)
        print("999999999999999999999999999")
        GRNetWork.getOneMyOrderDataByOrderID(paras) { (_, _, data, err) -> Void in
            let json = JSON(data: data!)
            if json["1"].int != 0 {
                print(json["1"][0])
                self.myOrderDetailItem.setDate(json["1"][0])
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.setDataItem()
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func setDataItem() {
        if (!self.dataItems.isEmpty) {
            self.dataItems.removeAll()
        }
        
        self.dataItems.append(["订单详情": "订单编号 \(self.myOrderDetailItem.a_id)"]);
        self.dataItems.append(["商家": "\(self.myOrderDetailItem.orderDetail.sender)"]);
        self.dataItems.append(["联系人": "\(self.myOrderDetailItem.orderDetail.contacts)"]);
        self.dataItems.append(["联系方式": "\(self.myOrderDetailItem.orderDetail.phone_num)"]);
        self.dataItems.append(["下单时间": "\(self.myOrderDetailItem.acceptTime)"]);
        switch self.myOrderDetailItem.status {
        case 0:
            self.dataItems.append(["送达时间": "赶紧配送拉！"]);
            break;
        case 1:
            self.dataItems.append(["送达时间": "配送中"]);
            break;
        case 2:
            self.dataItems.append(["送达时间": "\(self.myOrderDetailItem)"]);
        default:
            self.dataItems.append(["送达时间": "已取消"]);
            break
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
