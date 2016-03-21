//
//  SearchViewController.swift
//  Second_IOS
//
//  Created by 张轾林 on 15/12/9.
//  Copyright © 2015年 13110100224. All rights reserved.
//

import UIKit
import Alamofire


class ConsolesViewController: UIViewController, UISearchBarDelegate {
    
    var lineChart : ZFLineChart!
    var pieChart : ZFPieChart!
    
    var increButton : UIButton!
    var decrButton : UIButton!
    
    var cartemp  = [Int]()
    
    var refreshHeaderView : PZPullToRefreshView?
    var reloading : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="控制台"
        self.navigationController?.navigationBar.translucent = false
        
        self.JSON()
        
        self.increButton = UIButton(frame: CGRectMake(15,140,80,50))
        self.increButton.setTitle("+", forState: UIControlState.Normal)
        self.increButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        //self.increButton.backgroundColor =  UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        self.increButton.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        self.increButton.addTarget(self, action: Selector("PressIncreaseButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.increButton.enabled = true
        
        self.decrButton = UIButton(frame: CGRectMake(320,140,80,50))
        self.decrButton.setTitle("-", forState: UIControlState.Normal)
        self.decrButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.decrButton.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        self.decrButton.addTarget(self, action: Selector("PressDescendButton"), forControlEvents: UIControlEvents.TouchUpInside)
        self.decrButton.enabled = true
        
        
        //iphone6s plus 尺寸414*736
        let gradientLayer = CAGradientLayer().GradientLayer()
        gradientLayer.frame = self.view.frame
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        self.lineChart = ZFLineChart(frame: CGRectMake(0,(self.view.frame.height/2)-100,self.view.frame.width-10,self.view.frame.height/2))
        self.lineChart.title = "温度变化曲线"
        self.lineChart.xLineValueArray = NSMutableArray(array: ["2","5","15","4","1","6","2","3"])
        self.lineChart.xLineTitleArray = NSMutableArray(array: ["6时","8时","10时","12时","14时","16时","18时","20时"])
        self.lineChart.yLineMaxValue = 12
        self.lineChart.yLineSectionCount = 10
        
        self.view.addSubview(self.lineChart)
        self.lineChart.strokePath()
        
        self.pieChart = ZFPieChart(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/2-10))
        self.pieChart.title = "车辆温度"
        
        self.PieSwitch()
        

        /*
        self.pieChart.valueArray  = NSMutableArray(array: ["32","32","32","32","32","32","32","136"])
        self.pieChart.nameArray = NSMutableArray(array:["-5℃", "-2℃", "-0℃","4","8","10","12","15","温度异常"] )
        self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0),
        UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0),
        UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0),
        UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0),
        UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0),
        UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0),
        UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0),
        UIColor.whiteColor()
        ])
        */
        //self.pieChart.percentType = kPercentTypeInteger
        self.view.addSubview(self.lineChart)
        self.lineChart.strokePath()
        self.view.addSubview(self.pieChart)
        self.view.addSubview(self.increButton)
        self.view.addSubview(self.decrButton)
        self.pieChart.strokePath()
    }
    
    
    func  PressIncreaseButton()
    {
        Alamofire.request(.GET, "http://localhost/carTempture/receive.php/", parameters: ["T_range":1])
        //var test = request(.GET, "http://localhost/carTempture/receive.php/", parameters: ["T_range":4])
        //print(test)
        print("Press + Button")
        self.increButton.removeFromSuperview()
        self.reloadPieChar()
    }
    
    func PressDescendButton()
    {
        Alamofire.request(.GET, "http://localhost/carTempture/receive.php/", parameters: ["T_range":0])
        print("Press - Button")
        self.decrButton.removeFromSuperview()
        self.reloadPieChar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func  PieSwitch ()
    {
        switch ( cartemp.removeLast() )
        {
        case 1:
            self.pieChart.valueArray = NSMutableArray(array: ["-5"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)])
        case 2:
            self.pieChart.valueArray = NSMutableArray(array: ["-2"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)])
        case 3:
            self.pieChart.valueArray = NSMutableArray(array: ["1"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)])
        case 4:
            self.pieChart.valueArray = NSMutableArray(array: ["3"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)])
        case 5:
            self.pieChart.valueArray = NSMutableArray(array: ["5"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)])
        case 6:
            self.pieChart.valueArray = NSMutableArray(array: ["7"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)])
        case 7:
            self.pieChart.valueArray = NSMutableArray(array: ["10"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor(red: 134.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1.0)])
        default:
            self.pieChart.valueArray = NSMutableArray(array: ["15"])
            self.pieChart.colorArray = NSMutableArray(array: [UIColor.redColor()])
            break
            
        }
    }
    
    func  JSON()
    {
        //利用json获取当前四司机汽车的温度
        var  data :  NSData?
        
        let sem = dispatch_semaphore_create(0);
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(NSURLRequest(URL: NSURL(string: "http://localhost/carTempture/getdrive.php")!)) { (data1, response, error) -> Void in
            data = data1!
            dispatch_semaphore_signal(sem)
        }
        
        task.resume()
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        
        
        do {
            let jsonObj = try  NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                as! NSMutableArray
            // print(jsonObj.description)
            for driver in jsonObj
            {
                //                let nametemp = driver["driver_name"] as! NSMutableString
                //                name.append(nametemp)
                
                let car = Int(driver["T_range"] as! String)
                cartemp.append(car!)
            }
            
        }catch
        {
            print("shit")
        }
    }
    
    func  reloadPieChar()
    {
        self.JSON()
        self.PieSwitch()
        self.view.addSubview(self.lineChart)
        self.lineChart.strokePath()
        self.view.addSubview(self.pieChart)
        self.view.addSubview(self.increButton)
        self.view.addSubview(self.decrButton)
        self.pieChart.strokePath()
    }
    
}


