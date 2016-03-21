//
//  MapViewController.swift
//  LoginUI
//
//  Created by 张轾林 on 15/12/4.
//  Copyright © 2015年 张轾林. All rights reserved.
//

import UIKit


class MapViewController: UIViewController ,BMKMapViewDelegate{
    
    var seg:UISegmentedControl! //分段控件
    
    var view_mapView: UIView!
    var swh_Road: UISwitch!
    var Lab_Road: UILabel!
    var swh_Hot: UISwitch!
    var Lab_Hot: UILabel!
    
    
    var mapView: BMKMapView!
    
    override  func  loadView() {
        super.loadView()
        let  rect = CGRectMake(122,2, 172 , 35)
        let  items = ["矢量地图","卫星地图"]
        self.seg = UISegmentedControl(items: items)
        self.seg.frame = rect
        
        self.swh_Road =  UISwitch()
        self.swh_Road.frame.origin = CGPoint(x:50,y:5)
        self.Lab_Road = UILabel(frame:CGRectMake(10,2,40,35))
        
        self.swh_Hot = UISwitch()
        self.Lab_Hot = UILabel(frame: CGRectMake(300,2,60,35))
        self.swh_Hot.frame.origin = CGPoint(x:360,y:5)
        
        self.view_mapView = UIView(frame: CGRectMake(0,20,self.view.frame.width,self.view.frame.height))
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Lab_Road.text = "路况"
        self.Lab_Hot.text = "热力图"
        let rightItem=UIBarButtonItem(title:"查询",style:.Plain,target:self,action:"leftItemNext");
        rightItem.tintColor = UIColor.whiteColor();
        self.navigationItem.rightBarButtonItem = rightItem;
        self.navigationController?.navigationBar.translucent = false
        self.title="地图"
        
        self.seg.selectedSegmentIndex = 0
        self.swh_Road.on = false
        self.swh_Hot.on = false
        
        self.mapView = BMKMapView(frame: self.view_mapView.frame)
        self.mapView.trafficEnabled = false
        self.mapView.buildingsEnabled = true
        self.mapView.baiduHeatMapEnabled = false
        self.mapView.mapType = UInt(BMKMapTypeStandard)
        self.view_mapView.removeFromSuperview()
        
        self.view.addSubview(self.view_mapView)
        self.view_mapView.addSubview(self.mapView)
        self.view.addSubview(self.swh_Road)
        self.view.addSubview(self.Lab_Road)
        self.view.addSubview(self.Lab_Hot)
        self.view.addSubview(self.swh_Hot)
        self.view.addSubview(self.seg)
        
        self.swh_Road.onTintColor = UIColor.grayColor()
        self.swh_Road.addTarget(self, action: Selector("selectRoad"), forControlEvents: UIControlEvents.ValueChanged)
        self.swh_Hot.onTintColor = UIColor.grayColor()
        self.swh_Hot.addTarget(self, action: Selector("selectHot"), forControlEvents: UIControlEvents.ValueChanged)
        self.seg.tintColor = UIColor.blueColor()
        self.seg.selectedSegmentIndex = 3
        self.seg.addTarget(self, action: Selector("segment:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func leftItemNext()
    {
        self.navigationController?.pushViewController(LocationViewController(), animated: true)
    }

    
    func  segment(sender: UISegmentedControl)
    {
        let index = seg.selectedSegmentIndex
        switch index {
        case 0:
            mapView.mapType = UInt(BMKMapTypeStandard)
        default:
            mapView.mapType = UInt(BMKMapTypeSatellite)
        }
//        if  self.seg.selectedSegmentIndex == 1
//        {
//            self.showDetailViewController(MapViewController(), sender: nil)
//        }
//        else if self.seg.selectedSegmentIndex == 0
//        {
//                let sub = LocationViewController()
//                sub.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//                self.presentViewController(sub, animated: true , completion: nil)
        //}
        
    }
    
    func  selectRoad()
    {
        if self.swh_Road.on
        {
            self.mapView.trafficEnabled = true
        }
        else
        {
            self.mapView.trafficEnabled = false
        }
    }
    
    func  selectHot()
    {
        if self.swh_Hot.on
        {
            self.mapView.baiduHeatMapEnabled = true
        }
        else
        {
            self.mapView.baiduHeatMapEnabled = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.mapView.viewWillAppear()
        self.mapView.delegate = self  // 此处记得不用的时候需要置nil，否则影响内存的释放
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.mapView.viewWillDisappear()
        self.mapView.delegate = nil  // 不用时，置nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}
