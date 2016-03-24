//
//  UILabelPadding.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/17.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class UILabelPadding : UILabel {
    
    private var padding = UIEdgeInsetsZero
    
    @IBInspectable
    var paddingLeft: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue }
    }
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.padding
        var rect = super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
    
    class func getTxtSize(font: UIFont, txt: String) -> CGSize {
        let size = (txt as NSString).sizeWithAttributes([NSFontAttributeName: font])
        return size
    }
    
    class func getTxtMRect(text: String, contentWidth: CGFloat, font: UIFont) -> CGRect {
        let content = text as NSString
        let size = content.boundingRectWithSize(CGSizeMake(contentWidth, 500), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return size
    }
    
    
    class func getLabelRect(label: UILabelPadding) -> CGRect {
        var rect = CGRect()
        rect.origin = label.frame.origin
        rect.size.height = UILabelPadding.getTxtSize(label.font, txt: label.text!).height + label.paddingTop + label.paddingBottom
        rect.size.width = UILabelPadding.getTxtSize(label.font, txt: label.text!).width + label.paddingLeft + label.paddingRight
        
        return rect
    }
    
}

extension UILabelPadding {
    func resetFrameByTxtRect() {
        self.bounds.size = UILabelPadding.getTxtSize(self.font, txt: self.text!)
    }
}
