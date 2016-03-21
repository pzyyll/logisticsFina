//
//  DriverInformationViewController.swift
//  Second_IOS
//
//  Created by 张轾林 on 15/12/22.
//  Copyright © 2015年 13110100224. All rights reserved.
//

import UIKit
//import Alamofire

class DriverInformationViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate , UIGestureRecognizerDelegate, UISearchBarDelegate{

    var  tableView : UITableView!
    private let identify : String = "aCell"
    var name = [NSMutableString]()
    var age  = [Int]()
    var sex  = [NSMutableString]()
    var img = [String?]()
    var driver = NSMutableArray()
    
//    var allnames:Dictionary<Int,[String]>!  //所有司机的字典
//    var ctrlsel:Dictionary<Int, [String]>=[:] // 搜索匹配的结果，Table View使用这个数组作为datasource
    var  allnames = [NSMutableString]()
    var  ctrlsel = [NSMutableString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let jsonFilePath = NSBundle.mainBundle().pathForResource("driverlist", ofType: "geojson")
//        print(jsonFilePath)
//
//       let  data = NSData(contentsOfFile: jsonFilePath!)
        
        var data: NSData?
        
        let sem = dispatch_semaphore_create(0);
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(NSURLRequest(URL: NSURL(string: "http://localhost/connectDatabase/getdrive.php")!)) { (data1, response, error) -> Void in
            data = data1!
            dispatch_semaphore_signal(sem)
        }
        task.resume()
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
//        Alamofire.request(.GET, "http://localhost/connectDatabase/getdrive.php").response { (request, Response, data1, error) -> Void in
//            data = data1
//            print(data)
//        }
        do {
            let jsonObj = try  NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            as! NSMutableArray
            print(jsonObj.description)
            for driver in jsonObj
            {
                //name =driver["name"] as! String
                let nametemp = driver["name"] as! NSMutableString
                name.append(nametemp)
               //print(name)
                
                let sextemp = driver["sex"] as! NSMutableString
                sex.append(sextemp)
                
                let agetemp = Int(driver["age"] as! String)
                age.append(agetemp!)
                
                let imgtemp = driver["img"] as? String
                img.append(imgtemp)
                print(imgtemp)
            }

        }catch
        {
            print("shit")
        }
        
        self.allnames = self.name
        self.ctrlsel = self.allnames
//        
//        print(name)
//        print(sex)
//        print(age)
        self.navigationController?.navigationBar.translucent = false
        self.title = "司机信息"
        
        self.tableView = UITableView(frame: CGRectMake(0,0, self.view.frame.width, self.view.frame.height),style: UITableViewStyle.Grouped)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identify)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("tableviewCellLongPressed:"))
        longPress.delegate = self
        longPress.minimumPressDuration = 1.0
        self.tableView.addGestureRecognizer(longPress)
        
        let searchBar = UISearchBar()  //创建UISearchBar对象
        searchBar.sizeToFit()          //
        searchBar.showsCancelButton = true //显示取消按钮
        searchBar.delegate=self                //设置搜索条的委托
        self.tableView.tableHeaderView = searchBar //为表添加搜索条
        
        self.view.addSubview(self.tableView)
        

        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return  1
    }
    
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.name.count
    }
    
    func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath)
        cell.textLabel?.text = ((self.name[indexPath.row] as String) + "  " + (self.sex[indexPath.row] as String)
        + "  " + String(self.age[indexPath.row]))
        if (self.img[indexPath.row] != nil) {
            let imgdata = NSData(contentsOfURL: NSURL(string: self.img[indexPath.row]!)!)
            cell.imageView?.image = UIImage(data: imgdata!)
        } else {
            cell.imageView?.image = UIImage(named: "default.jpg")
        }
        
            //+ "  " +  (self.sex[indexPath.row] as String) + "  " + (self.age[indexPath.row] as String)
        //cell.textLabel!.text = self.ctrls[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return  cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableviewCellLongPressed(gestureRecongnizer:UILongPressGestureRecognizer)
    {
        if gestureRecongnizer.state == UIGestureRecognizerState.Ended
        {
            if self.tableView.editing == false
            {
                self.tableView.setEditing(true, animated: true)
            }
            else
            {
                self.tableView.setEditing(false, animated: true)
            }
        }
    }
    
    //MARK:删除数据
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        var data = self.name[indexPath.row]
        
        return  "确定删除\(data)"
    }
    
    //MARK:搜索代理UISearchBarDeledate方法,
    func  searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText == ""
        {
            self.ctrlsel = self.allnames
            //print(self.ctrlsel)
        }
        else
        {
            self.ctrlsel = []
            for ctrl in  self.allnames
            {
                if ctrl.hasPrefix(searchText)
                {
                    self.ctrlsel.append(ctrl)
                    print(self.ctrlsel)
                }
            }
        }
        
        self.tableView.reloadData()
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
