//
//  LoadingViewController.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/19.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    var imgView: UIImageView!
    var imgView2 = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        self.imgView = UIImageView()
        
        self.imgView.frame.size.width = 100
        self.imgView.frame.size.height = 100
        self.imgView.center = self.view.center
        self.imgView.center.y -= 100
        self.imgView.animationImages = [UIImage]()
        for i in 0..<14 {
            let str = String(format: "page_loading_%02d", i + 1)
            print(str)
            self.imgView.animationImages?.append(UIImage(named: str)!)
        }
        self.imgView.animationDuration = 0.8
        
        self.view.addSubview(imgView2)
        //self.view.addSubview(self.imgView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.imgView.startAnimating()
        self.imgView2.imgView.startAnimating()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //self.imgView.stopAnimating()
        self.imgView2.imgView.stopAnimating()
    }
    
    func showAnim(superview: UIView) {
        
    }
    
    func startAnim() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
