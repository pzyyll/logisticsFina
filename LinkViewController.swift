//
//  LinkViewController.swift
//  Second_IOS
//
//  Created by 张轾林 on 15/12/21.
//  Copyright © 2015年 13110100224. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController {

    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//      let Order:UIViewController = NewsViewController()
//      let OrderNav = UINavigationController(rootViewController: Order)
        
        let Maps:UIViewController = MapViewController()
        let MapsNav = UINavigationController(rootViewController: Maps)
        
        let Order:UIViewController = OrderViewController()
        let OrderNav = UINavigationController(rootViewController: Order)
        
        let Control:UIViewController = ConsolesViewController()
        let ControlNav = UINavigationController(rootViewController: Control)
        
        let MyView:UIViewController = MyViewController()
        let MyViewNav = UINavigationController(rootViewController: MyView)
        
        let  Tabbar = UITabBarController()
        let  TabbarArray = [OrderNav,MapsNav,ControlNav,MyViewNav]
        Tabbar.viewControllers = TabbarArray
        UINavigationBar.appearance().barTintColor = UIColor(red: 55.0/255.0, green: 168.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        var itemNameArray:[String] = ["icon_tab_discover","icon_tab_search","icon_tab_qa","icon_tab_user"];
        var itemNameSelectArray:[String] = ["icon_tab_discover_active","icon_tab_search_active","icon_tab_qa_active","icon_tab_user_active"];
        var ItemTitle:[String] = ["订单管理","地图","控制台","我的主页"];
        
        var count: Int = 0
        let items = Tabbar.tabBar.items
                let attributes =  [NSForegroundColorAttributeName: UIColor(red: 0.0/255.0, green: 154.0/255.0, blue: 97.0/255.0, alpha: 1.0), NSFontAttributeName: UIFont(name: "Heiti SC", size: 15.0)!]
        for item in items! as [UITabBarItem]
        {
            var image:UIImage = UIImage(named: itemNameArray[count])!
            var selectedimage:UIImage = UIImage(named: itemNameSelectArray[count])!
            image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            selectedimage = selectedimage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            item.selectedImage = selectedimage
            item.image = image
            item.title = ItemTitle[count]
            TabbarArray[count].tabBarItem = item
            item.setTitleTextAttributes(attributes, forState: UIControlState.Selected)
            count++
        }
        
       // self.view.backgroundColor = UIColor.whiteColor()
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.whiteColor()
        window!.rootViewController=Tabbar;
        window!.makeKeyAndVisible()
        self.view.addSubview(window!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
