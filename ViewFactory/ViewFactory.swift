//
//  ViewFactory.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/15.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import Foundation
import UIKit

enum CtrType {
    case Cell
    case Label
    case btn
    case NewOrderLabel
}

class ViewFactory {
    class func getDefautRect() -> CGRect {
        return CGRectMake(0, 0, 100, 30)
    }
    
    class func createCtr(type: CtrType, titles: [String]
        , action: Selector, sender: AnyObject?,
        otherConfig items: [AnyObject]!) -> UIView {
            switch type {
            case .btn:
                return self.createBtn(titles[0], antion: action, sender: sender)
            case .Label:
                return self.createLable(titles[0])
            case .Cell:
                return self.createCell()
            case .NewOrderLabel:
                return self.createNewOrderLabel(titles[0])
            }
    }
    
    class func createLable(title: String) -> UILabel {
        let label = UILabel(frame: ViewFactory.getDefautRect())
        label.text = title
        label.backgroundColor = UIColor.whiteColor()
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(12)
        return label
    }
    
    class func createCell() -> UITableViewCell {
        return UITableViewCell()
        
    }
    
    class func createNewOrderLabel(title: String) -> UILabelPadding {
        let label = UILabelPadding()
        label.frame = ViewFactory.getDefautRect()
        label.textColor = UIColor(red: 0, green: 111/255, blue: 1, alpha: 1)
        label.backgroundColor = UIColor.clearColor()
        label.text = title
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.layer.borderColor = UIColor(red: 0, green: 111/255, blue: 1, alpha: 1).CGColor
        label.layer.borderWidth = 0.8
        label.layer.cornerRadius = 1.5
        label.lineBreakMode = .ByTruncatingTail
        label.paddingLeft = 8
        label.paddingRight = 8
        label.paddingTop = 0
        label.paddingBottom = 0
        
        label.frame.size.height = 26
        label.frame.size.width = UILabelPadding.getTxtSize(label.font, txt: title).width + label.paddingLeft * 2
        
        return label
    }
    
    class func createBtn(title: String, antion: Selector, sender: AnyObject?) -> UIButton {
        let btn = UIButton(frame: ViewFactory.getDefautRect())
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(UIColor.myGreenColor(), forState: .Normal)
        btn.layer.borderColor = UIColor.myGreenColor().CGColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 2
        btn.setBackgroundImage(UIImage(named: "loginBtnClickedV2"), forState: .Highlighted)
        btn.clipsToBounds = true
        btn.userInteractionEnabled = true
        btn.addTarget(sender, action: antion, forControlEvents: .TouchUpInside)
        
        return btn
    }
}