//
//  MyOrderDetailViewController.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/20.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class MyOrderDetailViewController: UIViewController {


    var myOrderDetailItem: MyOrderItem!
    
   
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var correctBtn2: UIButton!
    
    var tableView: MyOrderDetailTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewConfig()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.correctBtn.titleLabel?.text = "开始配送"
        switch self.myOrderDetailItem.status {
        case 0:
            self.correctBtn2.setTitle("开始配送", forState: .Normal)
        case 1:
            self.correctBtn2.setTitle("确认送达", forState: .Normal)
        default:
            self.bottomView.removeFromSuperview()
        }
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
        self.view.addSubview(self.tableView)
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
        self.tabBarController?.tabBar.hidden = false
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
