//
//  MyOrderDetailTableView.swift
//  logistics
//
//  Created by CAIZHILI on 16/3/22.
//  Copyright © 2016年 张轾林. All rights reserved.
//

import UIKit

protocol MyOrderTableViewDataSource {
    func MyOrderTableView(numOfData num: Int) -> Int
    func MyOrderTableView(dataForRow row: Int) -> AnyObject?
}

class MyOrderDetailTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var cancelBtn: UIButton!
    var statusImg: UIImageView!
    var statusLabel: UILabel!
    var statusSubDetailLabel: UILabel!
    var seekPoints: [UIImageView]!
    var seekBars: [UIView]!
    var locatedPoint: UIImageView!
    var seekLabels: [UILabelPadding]!
    
    var dataItems: [[String: String]]!
    var dateDelegate: MyOrderTableViewDataSource!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.clearColor()
        self.bounces = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier: "13")
        self.dataItems = [[String: String]]()
        
        let rect = UIScreen.mainScreen().bounds
        let headerView = UIView(frame: CGRectMake(0, 0, rect.width, 165))
        headerView.backgroundColor = UIColor(red: 55/255, green: 168/255, blue: 122/255, alpha: 1)
        let headerContentView = UIView(frame: CGRectMake(8, 8, headerView.frame.width - 2 * 8, headerView.frame.height - 16));
        headerContentView.layer.cornerRadius = 4
        headerContentView.backgroundColor = UIColor.whiteColor()
        headerContentView.clipsToBounds = true
        let headerContentFootView = UIView(frame: CGRectMake(0, headerContentView.frame.height - 63, headerContentView.frame.width, 63));
        headerContentFootView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1);
        
        headerContentView.addSubview(headerContentFootView);
        headerView.addSubview(headerContentView);
        
        self.tableHeaderView = headerView
        
        self.statusImg = UIImageView(frame: CGRectMake(30, 26, 36, 36))
        self.statusImg.image = UIImage(named: "page_error")
        self.statusImg.backgroundColor = UIColor.myGreenColor()
        self.statusImg.layer.cornerRadius = 18
        self.statusImg.clipsToBounds = true
        headerContentView.addSubview(self.statusImg)
        
        self.statusLabel = ViewFactory.createCtr(CtrType.Label, titles: ["未配送"], action: nil, sender: nil, otherConfig: nil) as! UILabel
        self.statusLabel.frame = CGRectMake(self.statusImg.frame.width + self.statusImg.frame.origin.x + 14, self.statusImg.center.y - 27, 100, 27)
        self.statusLabel.font = UIFont.boldSystemFontOfSize(18)
        headerContentView.addSubview(self.statusLabel)
        self.statusSubDetailLabel = ViewFactory.createCtr(.Label, titles: ["赶紧送货啦！！"], action: nil, sender: nil, otherConfig: nil) as! UILabel
        self.statusSubDetailLabel.frame = CGRectMake(self.statusLabel.frame.origin.x, self.statusImg.center.y, 150, 21)
        self.statusSubDetailLabel.font = UIFont.systemFontOfSize(14)
        self.statusSubDetailLabel.textColor = UIColor.lightGrayColor()
        headerContentView.addSubview(self.statusSubDetailLabel)
        
        self.cancelBtn = ViewFactory.createCtr(CtrType.btn, titles: ["取消配送"], action: Selector("cancelAction:"), sender: self, otherConfig: nil) as! UIButton
        self.cancelBtn.frame = CGRectMake(headerContentView.frame.width - 30 - 80, 0, 80, 25)
        self.cancelBtn.center.y = self.statusImg.center.y
        self.cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        headerContentView.addSubview(self.cancelBtn)
        
        self.seekPoints = [UIImageView]()
        for _ in 0..<3 {
            let img = UIImageView(frame: CGRectMake(0, 0, 6, 6))
            //img.backgroundColor = UIColor.redColor()
            img.image = UIImage(named: "seekPoint_no_progress");
            headerContentFootView.addSubview(img)
            self.seekPoints.append(img)
        }
        self.seekPoints[1].center = CGPoint(x: headerContentFootView.frame.width/2, y: headerContentFootView.frame.height/2)
        self.seekPoints[0].center = CGPoint(x: self.seekPoints[1].center.x - 110, y: self.seekPoints[1].center.y)
        self.seekPoints[2].center = CGPoint(x: self.seekPoints[1].center.x + 110, y: self.seekPoints[1].center.y)
        
        self.seekBars = [UIView]()
        for i in 0..<2 {
            let view = UIView()
            view.frame.size = CGSizeMake(98, 0.5)
            view.backgroundColor = UIColor.lightGrayColor()
            view.frame.origin.x = self.seekPoints[i].center.x + self.seekPoints[i].frame.width/2 + 3
            view.center.y = self.seekPoints[i].center.y
            self.seekBars.append(view)
            headerContentFootView.addSubview(view)
        }
        
        self.locatedPoint = UIImageView(frame: CGRectMake(0, 0, 12, 12))
        self.locatedPoint.image = UIImage(named: "infoflow_located_city_icon")
        headerContentFootView.addSubview(self.locatedPoint)
        
        self.seekLabels = [UILabelPadding]()
        let strs = ["未配送", "配送中", "已送达"];
        var y: CGFloat = 0.0
        for i in 0..<3 {
            let label = AbsViewFactory(aFactory: FactoryForLablePaddingOfSubDetail()).createControl([strs[i]], action: nil, sender: nil, otherConfig: nil) as! UILabelPadding
            if i == 0 {
                y = self.seekPoints[i].frame.height + self.seekPoints[i].frame.origin.y
            }
            label.center.x = self.seekPoints[i].center.x
            label.frame.origin.y = y + 2
            self.seekLabels.append(label)
            headerContentFootView.addSubview(label)
        }
        
        self.setLocatePoint(0)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.dataItems.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 394)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "13")
        
        let (key, val) = self.dataItems![indexPath.row].first!
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        cell.selectionStyle = .None
        if indexPath.row == 0 {
            cell.selectionStyle = .Default
            cell.textLabel?.text = key
            cell.detailTextLabel?.text = val
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(10)
        } else {
            cell.textLabel?.text = "\(key) : \(val)"
            cell.textLabel?.textColor = UIColor.lightGrayColor()
            cell.textLabel?.font = UIFont.systemFontOfSize(12)
        }
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func cancelAction(sender: UIButton) {
        let ctr = self.parentViewController() as! MyOrderDetailViewController
        
        let aler = UIAlertController(title: "Del Warning!!", message: "Are you sure del del del??", preferredStyle: UIAlertControllerStyle.Alert)
        let okBtn = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (act) -> Void in
            let paras = ["order_num": ctr.myOrderDetailItem.orderDetail.orderID!,
                "a_id": ctr.myOrderDetailItem.a_id!,
                "status": "3"
            ]
            print(paras)
            GRNetWork.updateMyOrder(paras) { (_, _, data, err) -> Void in
                let json = JSON(data: data!)
                if json.int != 0 {
                    print(json)
                } else {
                    print(json)
                }
            }
        }
        let cancelBtn = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        aler.addAction(cancelBtn)
        aler.addAction(okBtn)
        ctr.presentViewController(aler, animated: true, completion: nil)
    }
    
    func setLocatePoint(point: Int) {
        let colorBlue = UIColor(red: 82/255, green: 173/255, blue: 231/255, alpha: 1)
        
        if (point < 3) {
            self.seekPoints[point].image = UIImage(named: "seekbar_scrubber_control_disabled");
            self.seekPoints[point].setScaler(5)
            self.locatedPoint.center.x = self.seekPoints[point].center.x
            self.locatedPoint.center.y = self.seekPoints[point].center.y - self.seekPoints[point].frame.height/2 - self.locatedPoint.frame.height/2
        }
        switch point {
        case 0:
            self.seekLabels[0].textColor = colorBlue
        case 1:
            self.seekLabels[point - 1].text = (self.parentViewController() as! MyOrderDetailViewController).myOrderDetailItem.start_distrubution
            self.seekLabels[point - 1].resetFrameByTxtRect()
            fallthrough
        case 2:
            self.seekBars[point - 1].backgroundColor = colorBlue
            self.seekBars[point - 1].layer.shadowColor = colorBlue.CGColor
            self.seekBars[point - 1].layer.shadowRadius = 1
            self.seekBars[point - 1].layer.shadowOffset = CGSize(width: 0, height: 0)
            self.seekBars[point - 1].layer.shadowOpacity = 0.6
            self.seekPoints[point - 1].image = UIImage(named: "seekPoint_pass")
            self.seekPoints[point - 1].setScaler(-5)
            self.seekLabels[point - 1].textColor = UIColor.lightGrayColor()
            self.seekLabels[point].textColor = colorBlue
        default:
            self.seekPoints[0].image = UIImage(named: "seekbar_scrubber_control_disabled-1")
            self.locatedPoint.image = UIImage(named: "infoflow_located_city_icon-1")
            self.seekLabels[0].text = "已取消"
            self.seekLabels[0].textColor = UIColor.lightGrayColor()
            break
        }
    }
    
    override func reloadData() {
        var count = 0
        dataItems.removeAll()
        if self.dateDelegate != nil {
            count = self.dateDelegate.MyOrderTableView(numOfData: 0)
            if count > 0 {
                for i in 0..<count {
                    let item = self.dateDelegate.MyOrderTableView(dataForRow: i) as! [String: String]
                    self.dataItems.append(item)
                    print(item)
                }
            }
        }
        super.reloadData()
    }

    func setStatus(status: Int) {
        switch status {
        case 0:
            break;
        case 1:
            self.statusLabel.text = "配送中"
            self.statusSubDetailLabel.text = "咻~咻~咻~"
            self.setLocatePoint(status)
            self.cancelBtn.removeFromSuperview()
            break;
        case 2:
            self.statusLabel.text = "已送达"
            self.statusSubDetailLabel.text = "棒棒哒！"
            for i in 1...2 {
                self.setLocatePoint(i)
            }
            self.cancelBtn.removeFromSuperview()
            break;
        default:
            self.cancelBtn.removeFromSuperview()
            self.statusLabel.text = "已取消"
            self.statusSubDetailLabel.text = "-_-!!"
            self.setLocatePoint(status)
            (self.parentViewController() as! MyOrderDetailViewController).bottomView.removeFromSuperview()
            break;
        }
    }
}
