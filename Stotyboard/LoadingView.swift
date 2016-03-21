//
//  LoadingView.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/19.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    var imgView: UIImageView!
    var imgs: [UIImage]?
    
    var selfCtr: ControllerDelegate!
    
    init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        self.imgView = UIImageView()
        
        self.imgView.frame.size.width = 100
        self.imgView.frame.size.height = 100
        self.imgView.center = self.center
        self.imgView.center.y -= 100
        self.imgView.animationDuration = 0.8
        self.imgView.userInteractionEnabled = true
        
        self.imgs = [UIImage]()
        self.setDefautiImgs()
        
        let tap = UITapGestureRecognizer(target: self, action: "reloading:")
        tap.numberOfTapsRequired = 1
        self.imgView.addGestureRecognizer(tap)
        
        self.addSubview(self.imgView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDefautiImgs() {
        for i in 1...14 {
            let str = String(format: "page_loading_%02d", i)
            self.imgs?.append(UIImage(named: str)!)
        }
        self.imgView.animationImages = self.imgs
    }
    
    func setImages(imgs: [UIImage]) {
        self.imgs = imgs
    }
    
    func setForErrCon() {
        self.imgs?.removeAll()
        self.imgs?.append(UIImage(named: "page_error")!)
    }
    
    func reloading(rec: UITapGestureRecognizer) {
        (self.selfCtr.getViewCtr() as! OrderViewController).loadNewOrderData()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
