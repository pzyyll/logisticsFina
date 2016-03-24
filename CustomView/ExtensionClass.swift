//
//  ExtensionClass.swift
//  logistics
//
//  Created by CAIZHILI on 16/3/22.
//  Copyright © 2016年 张轾林. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func myGreenColor() -> UIColor {
        return UIColor(red: 55/255, green: 168/255, blue: 122/255, alpha: 1)
    }
}

extension UIImageView {
    //缩小放大n个像素点
    func setScaler(px: CGFloat) {
        self.bounds.origin.x += -px
        self.bounds.origin.y += -px
        self.bounds.size.width += px
        self.bounds.size.height += px
    }
}