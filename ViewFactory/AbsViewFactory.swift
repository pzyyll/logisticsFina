//
//  AbViewFactory.swift
//  logistics
//
//  Created by CAIZHILI on 16/3/23.
//  Copyright © 2016年 张轾林. All rights reserved.
//

import Foundation
import UIKit

protocol AbsViewFactoryDelegete {
    func createControl(titles: [String]?
        , action: Selector, sender: AnyObject?,
        otherConfig items: [AnyObject]!) -> UIView
    
}

extension AbsViewFactoryDelegete {
    func create() -> UIViewController {
        return UIViewController()
    }
}

class AbsViewFactory: AbsViewFactoryDelegete {
    
    var viewFactory: AbsViewFactoryDelegete!
    
    func createControl(titles: [String]?, action: Selector,
        sender: AnyObject?, otherConfig items: [AnyObject]!) -> UIView {
            return viewFactory.createControl(titles, action: action, sender: sender, otherConfig: items)
    }
    init (aFactory: AbsViewFactoryDelegete) {
        self.viewFactory = aFactory
    }
    
    class func getDefaultFrame() -> CGRect {
        return CGRectMake(0, 0, 100, 30);
    }
}

//该标签样式应用场景在我的订单详情页配送状态下的三个标签
class FactoryForLablePaddingOfSubDetail: AbsViewFactoryDelegete {
    func createControl(titles: [String]?,action: Selector,
        sender: AnyObject?, otherConfig items: [AnyObject]!) -> UIView {
            let label = UILabelPadding();
            label.frame = AbsViewFactory.getDefaultFrame();
            label.textAlignment = .Center;
            label.textColor = UIColor.lightGrayColor()
            //label.backgroundColor = UIColor.redColor()
            label.text = titles![0]
            label.lineBreakMode = .ByWordWrapping
            label.font = UIFont.systemFontOfSize(10)
            var size = UILabelPadding.getTxtSize(label.font, txt: label.text!)
            //size.width += 1
            //size.height += 1
            label.frame.size = size
            print(size)
            return label
    }
}

