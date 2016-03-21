//
//  NewOrderTableViewCell.swift
//  CustomFram
//
//  Created by CAIZHILI on 16/3/14.
//  Copyright © 2016年 CAIZHILI. All rights reserved.
//

import UIKit

class NewOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentTitle: UILabel!

    @IBOutlet weak var createDate: UILabel!

    @IBOutlet weak var leftImgView: UIImageView!
    
    @IBOutlet weak var bottomLeftLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var phoneBtn: UIButton!
    
    @IBOutlet weak var customBgView: UIView!
    //@IBOutlet weak var customBgImgView: UIImageView!
    @IBOutlet weak var detailLabel1: UILabelPadding!
    var detailLabels = [UILabelPadding]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.leftImgView.layer.masksToBounds = true
        self.leftImgView.layer.cornerRadius = 20.4
        self.backgroundColor = UIColor.clearColor()
        
        self.customBgView.layer.shadowColor = UIColor.blackColor().CGColor
        self.customBgView.layer.shadowOffset = CGSizeMake(0, 0)
        self.customBgView.layer.shadowRadius = 2
        self.customBgView.layer.shadowOpacity = 0.24
        self.customBgView.layer.cornerRadius = 3
        
        self.detailLabel1.layer.borderWidth = 0.8
        self.detailLabel1.layer.borderColor = UIColor(red: 0, green: 111/255, blue: 1, alpha: 1).CGColor
        self.detailLabel1.textColor = UIColor(red: 0, green: 111/255, blue: 1, alpha: 1)
        self.detailLabel1.font = UIFont(name: "HelveticaNeue", size: 12)
        self.detailLabel1.layer.cornerRadius = 1.5
        self.detailLabel1.paddingLeft = 8
        self.detailLabel1.paddingRight = 8
        self.detailLabel1.paddingTop = 0
        self.detailLabel1.paddingBottom = 0
        //self.customBgView.frame.size.width -= 4
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        

        
//        self.customBgImgView.layer.masksToBounds = true
//        self.customBgImgView.layer.cornerRadius = 1
        //self.customBgImgView.frame = self.customBgView.frame
    }
    
    func setConfig(item: OrderItem) {
        self.contentTitle.text = item.org_Station + " → " + item.des_Station
        
        self.createDate.text = NewOrderTableViewCell.setTime(item.createDate!)
        
        if item.img == "" {
            self.leftImgView.image = UIImage(named: "headerImg")
        } else {
            let imgData = NSData(contentsOfURL: NSURL(string: item.img)!)
            self.leftImgView.image = UIImage(data: imgData!)
        }
        
        switch item.status {
        case 0:
            self.bottomLeftLabel.text = "订单状态: 尚无人接"
            self.bottomLeftLabel.textColor = UIColor.redColor()
        case 1:
            self.bottomLeftLabel.text = "订单状态: 已被接,未配送"
            self.bottomLeftLabel.textColor = UIColor.greenColor()
        default:
            break
        }
        self.userLabel.text = item.sender
        
        self.detailLabel1.text = item.T_range
        let dLabel = ViewFactory.createCtr(CtrType.NewOrderLabel, titles: ["\(item.loads)吨"], action: nil, sender: self, otherConfig: nil) as! UILabelPadding
        var rect = UILabelPadding.getLabelRect(self.detailLabel1)
        dLabel.frame.origin.y = rect.origin.y
        dLabel.frame.origin.x = rect.size.width + rect.origin.x + 10
        self.contentView.addSubview(dLabel)
        self.detailLabels.append(dLabel)
        if item.remark != "" {
            let rLabel = ViewFactory.createCtr(CtrType.NewOrderLabel, titles: [item.remark], action: nil, sender: self, otherConfig: nil) as! UILabelPadding
            rect = UILabelPadding.getLabelRect(dLabel)
            rLabel.frame.origin.y = rect.origin.y
            rLabel.frame.origin.x = rect.size.width + rect.origin.x + 10
            if (rLabel.frame.size.width + rLabel.frame.origin.x) > 385 {
                rLabel.frame.size.width = 385 - rLabel.frame.origin.x
            }
            self.contentView.addSubview(rLabel)
            self.detailLabels.append(rLabel)
        }
    }
    
    class func setTime(str: String) -> String {
        let dateForm = NSDateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateForm.dateFromString(str)
        let dCurTime = -Int((date?.timeIntervalSinceNow)!)
        
        var text = ""
        
        if dCurTime < 60 {
            text = "\(dCurTime) 秒前"
        } else if dCurTime < 3600 {
            let mins = dCurTime / 60
            text = "\(mins) 分钟前"
        } else if dCurTime < (24 * 3600) {
            let h = dCurTime / (60 * 60)
            text = "\(h) 小时前"
        } else if (dCurTime < (24 * 30 * 3600)) {
            let days = dCurTime / (24 * 3600)
            text = "\(days) 天前"
        } else {
            dateForm.dateFormat = "yyyy-MM-dd"
            text = dateForm.stringFromDate(date!)
        }
        
        return text
    }
    
}
