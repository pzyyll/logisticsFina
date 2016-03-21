//
//  MyViewController.swift
//  Second_IOS
//
//  Created by 张轾林 on 15/12/1.
//  Copyright © 2015年 13110100224. All rights reserved.
//

import UIKit

class MyViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    var maintableview:UITableView?
    var myScrollView:UIScrollView?
    var Array:NSArray!
    var Array1:NSArray!
    var Headview: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="我的主页"
        Array = NSArray()
        Array1 = NSArray()
        Array = ["我的收藏","我关注的问题","我关注的司机","周边的物流站点"]
        Array1 = ["我的提问","我的回答","专栏"]
        AddLeftandrightItem()
        NewMyTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AddLeftandrightItem(){
        
        let leftItem=UIBarButtonItem(title:"消息",style:.Plain,target:self,action:"leftItemNext");
        leftItem.tintColor = UIColor.whiteColor();
        self.navigationItem.leftBarButtonItem = leftItem;
        
        let rightItem=UIBarButtonItem(title:"设置",style:.Plain,target:self,action:"rightItemNext");
        rightItem.tintColor = UIColor.whiteColor();
        self.navigationItem.rightBarButtonItem = rightItem;
        self.navigationController?.navigationBar.translucent = false
        
    }
    
    func leftItemNext()
    {
        print("Message")
    }
    
    func rightItemNext()
    {
        print("Seting")
    }
    
    //Table布局
    func NewMyTable(){
        
        myScrollView = UIScrollView(frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        myScrollView!.contentSize.height = CGFloat(self.view.frame.size.height)
        myScrollView!.contentSize.width = CGFloat(self.view.frame.size.width)
        myScrollView!.showsHorizontalScrollIndicator = false
        myScrollView!.showsVerticalScrollIndicator   = true
        self.view.addSubview(myScrollView!)
//        let Heaberview = (NSBundle.mainBundle().loadNibNamed("HanderView", owner: nil, options: nil)[0] as? HanderView)
//        Heaberview!.frame = CGRectMake(0, 0, self.view.frame.size.width, 150)
//        Heaberview!.backgroundColor = UIColor(red: 55.0/255.0, green: 168.0/255.0, blue: 122.0/255.0, alpha: 1.0)
//        myScrollView!.addSubview(Heaberview!)

        self.Headview = UIImageView(image: UIImage(named:"myimage")!)
        self.Headview.frame = CGRectMake(0, 0, self.view.frame.size.width, 150)
        self.Headview.backgroundColor = UIColor(red: 55.0/255.0, green: 168.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        myScrollView?.addSubview(Headview)
        
        maintableview = UITableView(frame: CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-170))
        maintableview!.dataSource = self
        maintableview!.delegate   = self
        maintableview!.backgroundColor = UIColor.whiteColor()
        myScrollView!.addSubview(maintableview!)
        //let footview = UIView(frame: CGRectZero)
        //maintableview!.tableFooterView = footview
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            
            return Array.count
        }
        return Array1.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==0){
            return 30
        }
        if(section==1){
            return 15
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell:(UITableViewCell) = UITableViewCell(style:.Default,reuseIdentifier:"Identifier") as UITableViewCell
        
        if(indexPath.section==0){
            cell.textLabel!.text = Array.objectAtIndex(indexPath.row) as? String
            
        }
        if(indexPath.section==1){
            cell.textLabel!.text = Array1.objectAtIndex(indexPath.row) as? String
            
        }
        cell.textLabel!.text = Array.objectAtIndex(indexPath.row) as? String
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel!.font = UIFont.systemFontOfSize(14)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.section==0){
            
            print(indexPath.row)
            if (indexPath.row == 2 )
            {
               // self.showDetailViewController(DriverInformationViewController(), sender: nil)
                self.navigationController?.pushViewController(DriverInformationViewController(), animated: true)
                
            }
            
        }else{
            
            print(indexPath.row)
        }
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if(scrollView == self.maintableview!){
            
            if (scrollView.contentOffset.y<=30&&scrollView.contentOffset.y>=0) {
                
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
                
            } else if (scrollView.contentOffset.y>=30) {
                
                scrollView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
                
            }
        }
        
    }
    
}
