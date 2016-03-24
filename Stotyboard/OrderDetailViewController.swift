//
//  OrderDetailViewController.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/17.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {

    var orderDetail: OrderItem!
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var releaseTime: UILabel!
    @IBOutlet weak var od_station: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    var remarkLabel2: UILabelPadding!
    @IBOutlet weak var contacts: UILabel!
    @IBOutlet weak var touch_way: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var detaiView2: UIView!
    
    @IBOutlet weak var bottomToolView: UIView!
    @IBOutlet weak var bottomBtn: UIButton!
    var interval = CGFloat()
    var firstLoadFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        self.title = "订单详情"
        
        self.viewConfig()
        //self.dataSourceConfig()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        if self.firstLoadFlag == 0 {
            self.dataSourceConfig()
            self.firstLoadFlag = 1
        } 
    }
    
    override func viewDidLayoutSubviews() {
        self.detailView.frame.size.height += interval

        //self.dataSourceConfig()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(animated: Bool) {
        print(self.detaiView2.frame)
    }

    func back() {
        self.navigationController?.popViewControllerAnimated(true)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func viewConfig() {
        //back btn
        let img = UIImage(named: "Arrow_Back_72px")
        let backBtnItem = UIBarButtonItem(image: UIImage(data: UIImagePNGRepresentation(img!)!, scale: 2.8), style: .Plain, target: self, action: Selector("back"))
        backBtnItem.tintColor = UIColor.whiteColor()
        backBtnItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        self.navigationItem.leftBarButtonItem = backBtnItem
        
        
        //config bottomToolView
        self.bottomToolView.layer.shadowColor = UIColor.blackColor().CGColor
        self.bottomToolView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.bottomToolView.layer.shadowRadius = 1
        self.bottomToolView.layer.shadowOpacity = 0.4
        
        //
        self.userImg.layer.masksToBounds = true
        self.userImg.layer.cornerRadius = 20
        
        self.remarkLabel2 = UILabelPadding()
        self.remarkLabel2.lineBreakMode = .ByWordWrapping
        self.remarkLabel2.numberOfLines = 100
        self.remarkLabel2.font = self.remarkLabel.font
        self.remarkLabel2.frame = self.remarkLabel.frame
    }
    
    func dataSourceConfig() {
        self.username.text = self.orderDetail.sender
        self.releaseTime.text = NewOrderTableViewCell.setTime(self.orderDetail!.createDate)
        self.contacts.text = self.orderDetail.contacts
        self.touch_way.text = self.orderDetail.phone_num
        self.touch_way.text!.replaceRange(Range(start: self.touch_way.text!.startIndex.advancedBy(3), end: self.touch_way.text!.endIndex.advancedBy(-4)), with: "****")
        self.address.text = self.orderDetail.org_Station
        self.od_station.text = self.orderDetail.org_Station + " → " + self.orderDetail.des_Station
        var labels = [UILabelPadding]()
        labels.append(ViewFactory.createNewOrderLabel(self.orderDetail.T_range))
        labels.append(ViewFactory.createNewOrderLabel("\(self.orderDetail.loads!)吨"))
        labels.append(ViewFactory.createNewOrderLabel("\(self.orderDetail.time_range)h"))
        labels.append(ViewFactory.createNewOrderLabel(self.orderDetail.goodsType))
        
        let point = CGPoint(x: 22, y: 114)
        for i in 0..<labels.count {
            if i == 0 {
                labels[i].frame.origin = point
            } else {
                let rect = UILabelPadding.getLabelRect(labels[i - 1])
                labels[i].frame.origin.x = rect.origin.x + rect.width + 8
                labels[i].frame.origin.y = rect.origin.y
            }
            self.detailView.addSubview(labels[i])
        }
        
        if self.orderDetail.remark != "" {
            let rect = UILabelPadding.getTxtMRect(self.orderDetail.remark, contentWidth: self.remarkLabel.frame.width, font: self.remarkLabel.font)
            print(rect)
            
            interval = self.remarkLabel.frame.height
            self.remarkLabel2.frame.size.height = rect.height
            interval = self.remarkLabel2.frame.size.height - interval
            self.remarkLabel2.text = self.orderDetail.remark
            self.remarkLabel.removeFromSuperview()
            self.detailView.addSubview(self.remarkLabel2)
            
            //self.detailView.frame.size.height += interval
            for view in self.detaiView2.subviews {
                view.frame.origin.y += interval
            }
        } else {
            self.remarkLabel.text = "无"
        }
        
        if self.orderDetail.status == 1 {
            self.bottomBtn.setTitle("来晚一步了~", forState: .Disabled)
            self.bottomBtn.enabled = false
        }
        
    }
    
    @IBAction func callAction(sender: UIButton) {
//        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
//        UIWebView * callWebview = [[UIWebView alloc] init];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//        [self.view addSubview:callWebview];
        
        let str = String(format: "tel:%@", self.orderDetail.phone_num)
        let callView = UIWebView()
        callView.loadRequest(NSURLRequest(URL: NSURL(string: str)!))
        self.view.addSubview(callView)
        print("heh")
    }
    
    
    @IBAction func receiveOrderAction(sender: UIButton) {
        //let loadingView = LoadingViewController()
        //self.navigationController?.pushViewController(loadingView, animated: true)
        
        let sb = UIStoryboard(name: "Storyboard", bundle: nil)
        let cvc = sb.instantiateViewControllerWithIdentifier("correctView") as! CorrectViewController
        cvc.orderDetail = self.orderDetail
        self.navigationController?.pushViewController(cvc, animated: true)


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
