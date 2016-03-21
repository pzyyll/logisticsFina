//
//  LocationViewController.swift
//  logistics
//
//  Created by 张轾林 on 16/3/15.
//  Copyright © 2016年 张轾林. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController ,UITextFieldDelegate , BMKMapViewDelegate , BMKPoiSearchDelegate{

    var labelFirst: UILabel!
    var labelSecond: UILabel!
    var txf_City: UITextField!
    var txf_Search: UITextField!
    var btn_Search: UIButton!
    var btn_Next: UIButton!
    
    
    
    override  func  loadView() {
        super.loadView()
        
        self.labelFirst = UILabel(frame: CGRectMake(16,4,17,21))
        self.labelSecond = UILabel(frame: CGRectMake(166,4,68,21))
        self.txf_City = UITextField(frame: CGRectMake(41,1,117,30))
        self.txf_Search = UITextField(frame: CGRectMake(242,1,242,30))
        self.btn_Search = UIButton(frame: CGRectMake(16,35,90,20))
        self.btn_Next = UIButton(frame:CGRectMake(280,35,90,20))
        

    }
    
    // 开始搜
    func Search(sender: UIButton) {
        currentPage = 0
        let citySearchOption = BMKCitySearchOption()
        citySearchOption.pageIndex = Int32(currentPage)
        citySearchOption.pageCapacity = 10
        citySearchOption.city = txf_City.text
        citySearchOption.keyword = txf_Search.text
        if poisearch.poiSearchInCity(citySearchOption) {
            btn_Next.enabled = true
            print("城市内检索发送成功！")
        }else {
            btn_Next.enabled = false
            print("城市内检索发送失败！")
        }
    }
    
    // 查看下一组数据
    func NextData(sender: UIButton) {
        currentPage++
        // 城市内检索，请求成功发送返回 true，请求失败返回 false
        let citySearchOption = BMKCitySearchOption()
        citySearchOption.pageIndex = Int32(currentPage)
        citySearchOption.pageCapacity = 10
        citySearchOption.city = txf_City.text
        citySearchOption.keyword = txf_Search.text
        if poisearch.poiSearchInCity(citySearchOption) {
            btn_Next.enabled = true
            print("城市内检索发送成功！")
        }else {
            btn_Next.enabled = false
            print("城市内检索发送失败！")
        }
    }
    
    /// 百度地图视图
    var mapView: BMKMapView!
    /// Poi 搜索
    var poisearch: BMKPoiSearch!
    /// 搜索页面
    var currentPage = 0
    
    // 界面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置标题
        self.navigationController?.navigationBar.translucent = false
        self.title="地图"
        
        self.labelFirst.text = "在"
        self.labelSecond.text = "市内查找"
        self.labelFirst.textAlignment = NSTextAlignment.Right
        self.labelSecond.textAlignment = NSTextAlignment.Right
        self.labelFirst.font = UIFont.systemFontOfSize(17)
        self.labelSecond.font = UIFont.systemFontOfSize(17)
        
        self.txf_City.borderStyle = UITextBorderStyle.RoundedRect
        self.txf_City.returnKeyType = UIReturnKeyType.Done
        self.txf_City.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.txf_City.delegate = self
        self.txf_Search.borderStyle = UITextBorderStyle.RoundedRect
        self.txf_Search.returnKeyType = UIReturnKeyType.Done
        self.txf_Search.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.txf_Search.delegate = self
        
        self.btn_Search.setTitle("开始搜索", forState: UIControlState.Normal)
        self.btn_Search.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.btn_Search.setTitle("开始搜索", forState:UIControlState.Highlighted) //触摸状态下的文字
        self.btn_Search.backgroundColor = UIColor.whiteColor()
        self.btn_Search.addTarget(self, action: Selector("Search:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.btn_Search.enabled = true
        
        self.btn_Next.setTitle("下一组数据", forState: UIControlState.Normal)
        self.btn_Next.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.btn_Next.setTitle("下一组数据", forState:UIControlState.Highlighted) //触摸状态下的文字
        self.btn_Next.backgroundColor = UIColor.whiteColor()
        self.btn_Next.addTarget(self, action: Selector("NextData:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.btn_Next.enabled =  true

        
        // 地图界面初始化
        mapView = BMKMapView(frame: view.frame)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        self.view.addSubview(self.labelSecond)
        self.view.addSubview(self.labelFirst)
        self.view.addSubview(self.txf_City)
        self.view.addSubview(self.txf_Search)
        self.view.addSubview(self.btn_Next)
        self.view.addSubview(self.btn_Search)
        
        // 界面初始化
        txf_City.text = "大连"
        txf_Search.text = "物流"
        mapView.zoomLevel = 13
        
        mapView.isSelectedAnnotationViewFront = true
        
        // Poi 搜索初始化
        poisearch = BMKPoiSearch()
        
        // 创建地图视图约束
        var constraints = [NSLayoutConstraint]()
        constraints.append(mapView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor))
        constraints.append(mapView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor))
        constraints.append(mapView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor))
        constraints.append(mapView.topAnchor.constraintEqualToAnchor(btn_Search.bottomAnchor, constant: 8))
        self.view.addConstraints(constraints)
    }
    
    // MARK: - 覆盖物协议设置
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        // 生成重用标示 ID
        let annotationViewID = "Mark"
        
        // 检查是否有重用的缓存
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationViewID) as? BMKPinAnnotationView
        
        // 缓存若没有命中，则自己构造一个，一般首次添加 annotation 代码会运行到此处
        if annotationView == nil {
            annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationViewID)
            annotationView!.pinColor =  UInt(BMKPinAnnotationColorRed)
            // 设置标注从天上掉下来的效果
            annotationView!.animatesDrop = true
        }
        
        // 设置位置
        annotationView!.centerOffset = CGPointMake(0, -(annotationView!.frame.size.height * 0.5))
        annotationView!.annotation = annotation
        // 单击弹出泡泡，弹出泡泡的前提是 annotation 必须实现 title 属性
        annotationView!.canShowCallout = true
        // 设置是否可以拖拽
        annotationView!.draggable = false
        
        return annotationView
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        mapView.bringSubviewToFront(view)
        mapView.setNeedsDisplay()
    }
    
    func mapView(mapView: BMKMapView!, didAddAnnotationViews views: [AnyObject]!) {
        print("标注添加前的方法调用")
    }
    
    // MARK: - Poi 搜索的相关方法实现
    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        // 清除屏幕中所有的 annotation
        let array = mapView.annotations
        mapView.removeAnnotations(array)
        
        if errorCode.rawValue == 0 {
            for i in 0..<poiResult.poiInfoList.count {
                let poi = poiResult.poiInfoList[i] as! BMKPoiInfo
                let item = BMKPointAnnotation()
                item.coordinate = poi.pt
                item.title = poi.name
                mapView.addAnnotation(item)
                if i == 0 {
                    // 将第一个点的坐标移到屏幕中央
                    mapView.centerCoordinate = poi.pt
                }
            }
        }else if errorCode.rawValue == 2 {
            print("起始点有歧义")
        }else {
            // 各种情况的判断……
        }
    }
    
    // MARK: - 协议代理设置
    
    override func viewWillAppear(animated: Bool) {
        mapView.viewWillAppear()
        mapView.delegate = self  // 此处记得不用的时候需要置nil，否则影响内存的释放
        poisearch.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        mapView.viewWillDisappear()
        mapView.delegate = nil  // 不用时，置nil
        poisearch.delegate = nil
    }
    
    // MARK: - 内存管理
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
