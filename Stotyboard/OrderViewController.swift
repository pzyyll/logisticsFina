//
//  DiscoveryViewController.swift
//  Second_IOS
//
//  Created by 张轾林 on 15/12/3.
//  Copyright © 2015年 13110100224. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderViewController: UIViewController ,UIScrollViewDelegate, NewOrderTableViewDataSource, ControllerDelegate,
MyRecOrderTableViewDataSource {
    var ScreenWidth:Float?
    var ScreenHeight:Float?
    
    var mainScrollview:UIScrollView?
    var mainSlideView:UIView?
    var Slidebutton:UIButton?
    var Slidelabel:UILabel?
    var ButArray:NSMutableArray!
    var ViewArray:NSMutableArray!
    
    var newOrderView: NewOrderTableView!
    var newOrderRefreshCtr: UIRefreshControl!
    var myOrderView: MyOrderTableView!
    var myOrderRefreshCtr: UIRefreshControl!
    var orderLib = OrderLibrary()
    var myOrderLib = MyOrderLibrary()
    
    var loginFlag = 0;
    var timer: NSTimer!
    var loadinView: LoadingView!
    
    override func loadView() {
        super.loadView()
        self.newOrderRefreshCtr = UIRefreshControl()
        self.myOrderRefreshCtr = UIRefreshControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.title="订单管理"
        self.navigationController?.navigationBar.translucent = false
        ScreenWidth = Float(self.view.frame.size.width)
        ScreenHeight = Float(self.view.frame.size.height)
        ButArray = NSMutableArray()
        ViewArray = NSMutableArray()
        AddrightItem()
        SlideButton()
        NewMainScrollView()
        self.loadNewOrderData()
        self.loadingMyOrderData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func AddrightItem(){
        
        let NewItem=UIBarButtonItem(title:"摘要",style:.Plain,target:self,action:"NewItem");
        NewItem.tintColor = UIColor.whiteColor();
        //  添加到到导航栏上
        self.navigationItem.rightBarButtonItem = NewItem;
    }
    
    
    //滑动Button
    func SlideButton()
    {
        mainSlideView = UIView(frame: CGRectMake(0,0,CGFloat(ScreenWidth!),40))
        mainSlideView!.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view.addSubview(mainSlideView!)
        let ArrayTitle:[String] = ["最新订单","我的订单"];
        let ButtonH = ScreenWidth!/2
        for var index = 0; index < ArrayTitle.count; index++ {
            Slidebutton = UIButton(frame: CGRectMake(CGFloat(ButtonH)*CGFloat(index),0,CGFloat(ButtonH),40))
            Slidebutton!.tag = (index+1)*10
            Slidebutton!.setTitle(ArrayTitle[index], forState:UIControlState.Normal)
            Slidebutton!.addTarget(self, action:"SlidebuttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            Slidebutton!.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            Slidebutton!.titleLabel?.font = UIFont.systemFontOfSize(14.0)
            self.mainSlideView!.addSubview(Slidebutton!)
            ButArray.addObject(Slidebutton!)
            
            if(Slidebutton!.tag==10){
                Slidebutton!.setTitleColor(UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
                
            }
            
        }
        
        //Label
        Slidelabel = UILabel(frame: CGRectMake(0,38,CGFloat(ButtonH),2))
        Slidelabel!.backgroundColor = UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        self.mainSlideView!.addSubview(Slidelabel!)
    }
    
    /**
     点击事件
     */
    func SlidebuttonClick(sender:UIButton){
        
        UIView.animateWithDuration(0.2, animations: {
            self.Slidelabel!.frame = CGRectMake(sender.frame.origin.x, 38,CGFloat(self.ScreenWidth!)/2, 2);
        })
        
        for Btn in ButArray{
            
            if(Btn.tag == sender.tag){
                Btn.setTitleColor(UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
            }else{
                
                Btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            }
        }
        mainScrollview!.setContentOffset(CGPointMake(self.view.bounds.size.width * CGFloat((sender.tag-1)/10),0), animated: true)
        
    }
    
    /**
     *   底层的一个滚动视图
     */
    
    func NewMainScrollView()
    {
        mainScrollview = UIScrollView(frame: CGRectMake(0,40,CGFloat(ScreenWidth!),CGFloat(ScreenHeight!-44)))
        mainScrollview!.backgroundColor=UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        mainScrollview!.contentSize.height = CGFloat(ScreenWidth!-104)
        mainScrollview!.contentSize.width = CGFloat(ScreenWidth!)*2
        mainScrollview!.showsHorizontalScrollIndicator = false
        mainScrollview!.showsVerticalScrollIndicator   = false
        mainScrollview!.pagingEnabled = true
        mainScrollview!.scrollsToTop = false
        mainScrollview!.delegate = self
        self.view.addSubview(mainScrollview!)
        //添加子页面2个滑动页面
        //add new oreder view
        self.newOrderView = NewOrderTableView(frame: CGRectMake(0,
            0, CGFloat(ScreenWidth!), CGFloat(ScreenHeight!-104-48)),
            style: .Plain)
        
        self.newOrderView.frame.size.width -= 14
        self.newOrderView.frame.origin.x += 7
        self.newOrderView.tag = 0
        self.newOrderView.dataSourceOfOrder = self
        self.newOrderView.controllerDelegate = self
        self.newOrderView.reloadData()
        mainScrollview!.addSubview(self.newOrderView)
        //add refresh ctr
        self.newOrderRefreshCtr.addTarget(self, action: "newOrderRefreshData", forControlEvents: .ValueChanged)
        self.newOrderRefreshCtr.attributedTitle = NSAttributedString(string: "刷刷刷~")
        self.newOrderView.addSubview(self.newOrderRefreshCtr)
        
        //my order view
        self.myOrderView = MyOrderTableView(frame: CGRectMake(CGFloat(ScreenWidth!),
            0.0, CGFloat(ScreenWidth!), CGFloat(ScreenHeight!-104 - 48)), style: .Plain)
        self.myOrderView.tag = 1
        self.myOrderView.dataDelegate = self
        self.myOrderRefreshCtr.addTarget(self, action: "loadingMyOrderData", forControlEvents: .ValueChanged)
        self.myOrderRefreshCtr.attributedTitle = NSAttributedString(string: "刷刷刷~")
        self.myOrderView.ctrDelegate = self
        self.myOrderView.addSubview(self.myOrderRefreshCtr)
        self.mainScrollview?.addSubview(self.myOrderView)
        
        loadinView = LoadingView()
        loadinView.selfCtr = self
    }
    /**
     
     滚动视图停止滚动的方法
     */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let indexX:NSInteger = NSInteger(CGFloat(ScreenWidth!)/2 * (self.mainScrollview!.contentOffset.x/CGFloat(ScreenWidth!)))
        UIView.animateWithDuration(0.2, animations: {
            self.Slidelabel!.frame = CGRectMake(CGFloat(indexX), 38,CGFloat(self.ScreenWidth!)/2, 2);
        })
        
        let indexTag:NSInteger = NSInteger((mainScrollview!.contentOffset.x/CGFloat(self.ScreenWidth!)+1)*10)
        
        for Btn in ButArray{
            
            if(Btn.tag==indexTag)
            {
                Btn.setTitleColor(UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
            }else{
                
                Btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            }
        }
        
        
    }
    
    func  NewItem()
    {
        print("还没做-_-😢😢")
    }
    
    
    //自定义数据源
    func newOrderTableView(tableView: NewOrderTableView, numOfOrderLib num: Int) -> Int {
        return orderLib.OrderItems.count
    }
    
    func newOrderTableView(tableView: NewOrderTableView, dataForRow row: Int) -> OrderItem? {
        return orderLib.OrderItems[row]
    }
    
    func loadNewOrderData() {

        if self.loginFlag == 0 {
            self.view.addSubview(loadinView)
            loadinView.imgView.startAnimating()
        }
        if !self.orderLib.OrderItems.isEmpty {
            self.orderLib.OrderItems.removeAll()
        }
        GRNetWork.getAllOrderData { (requsest, response, data, err) -> Void in
            let json = JSON(data: data!)
            if json["1"] != nil {
                for item in json["1"].array! {
                    let aOrder = OrderItem()
                    aOrder.setData(item)
                    self.orderLib.OrderItems.append(aOrder)
                }
                if self.loginFlag == 0 {
                    self.loadinView.imgView.stopAnimating()
                    self.loadinView.removeFromSuperview()
                    self.loginFlag = 1
                    //self.timer = NSTimer(timeInterval: 10, target: self, selector: Selector("loadingTimeAction"), userInfo: <#T##AnyObject?#>, repeats: <#T##Bool#>)
                }
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.newOrderView.reloadData()
                    self.newOrderRefreshCtr.endRefreshing()
                }
            }
            else {
                print("123")
            }
        }
    }
    
    func getViewCtr() -> UIViewController? {
        return self
    }
    
    func newOrderRefreshData() {
        self.loadNewOrderData()
        //self.newOrderRefreshCtr.endRefreshing()
    }
    
    //与加载我的订单数据有关的两方法
    func MyRecOrderTableView(numOfOrderLib num: Int) -> Int {
        return myOrderLib.myOrderItems.count
    }
    func MyRecOrderTableView(dataForRow row: Int) -> MyOrderItem? {
        return myOrderLib.myOrderItems[row]
    }
    
    func loadingMyOrderData() {
        if !myOrderLib.myOrderItems.isEmpty {
            myOrderLib.myOrderItems.removeAll()
        }
        let user = NSUserDefaults.standardUserDefaults().valueForKey("user") as! String
        GRNetWork.getMyAllOrderData(["user": user]) { (_, _, data, _) -> Void in
            let jsonData = JSON(data: data!)
            if jsonData["1"] != nil {
                if jsonData["1"].int == 0 {
                    //其它处理
                } else {
                    print(jsonData["1"])
                    for item in jsonData["1"].array! {
                        let myOrderItem = MyOrderItem()
                        myOrderItem.setDate(item)
                        print(item)
//                        print(item["a_status"])
                        self.myOrderLib.myOrderItems.append(myOrderItem)
                    }
                    
                    //let queue = dispatch_queue_create("my.append_queue", dispatch_queue_attr_t!)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.myOrderView.reloadData()
                        self.myOrderRefreshCtr.endRefreshing()
                    })
                }
            }
        }
        
    }
    
}
