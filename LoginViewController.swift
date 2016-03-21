//
//  LoginViewController.swift
//  Second_IOS
//
//  Created by 13110100224 on 15/11/23.
//  Copyright © 2015年 13110100224. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate {
    
    var lableName: UILabel!
    var lablePassword: UILabel!
    var textName: UITextField!
    var textPassword: UITextField!
    
    var btSubmit: UIButton!
    var btRegister: UIButton!
    var btForgetPassword: UIButton!
    var btPage: UIButton!
    
    var switch_PS: UISwitch!
    var loginimage: UIImageView!
    
    var background: UIButton!
    
    override  func loadView() {
        super.loadView()
        
       // self.view.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 127/255, alpha: 1)
        //MARK: 设置登陆界面的label位置属性
        self.lableName = UILabel(frame: CGRectMake(20, 200, 80, 30))
        self.lablePassword = UILabel(frame: CGRectMake(20, 250, 80, 30))
        
        //MARK: 设置登陆界面的text位置属性
        self.textName = UITextField(frame: CGRectMake(130, 200, 210, 30))
        self.textPassword = UITextField(frame: CGRectMake(130, 250, 210, 30))
        
        //MARK: 设置登陆界面的Button位置属性
        self.btSubmit = UIButton(frame: CGRectMake(130, 300, 160, 30))
        self.btForgetPassword = UIButton(frame:CGRectMake(130, 350, 160, 30))
        self.btRegister = UIButton(frame: CGRectMake(130, 400, 160, 30))
        self.btPage = UIButton(frame: CGRectMake(130,450,160,30))
        
        //MARK: 设置登陆界面的switch位置的属性
        self.switch_PS = UISwitch()
        self.switch_PS.frame.origin = CGPoint(x:345,y:250)
        
        //MARK: 设置登陆界面的背景图片
        self.loginimage = UIImageView(image: UIImage(named:"imageSource")!)
        self.loginimage.frame = self.view.frame
        
        //MARK: 增加一个按钮用于用户点击背景图片之后时键盘退出
        self.background = UIButton(frame: CGRectMake( 0, 0, 414, 736))
        
        self.view.addSubview(loginimage)
        self.view.addSubview(background)
        //self.view.addSubview(switch_PS)
        self.view.addSubview(lableName)
        self.view.addSubview(lablePassword)
        self.view.addSubview(textName)
        self.view.addSubview(textPassword)
        self.view.addSubview(btRegister)
        self.view.addSubview(btSubmit)
        //self.view.addSubview(btPage)
        self.view.addSubview(btForgetPassword)
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //MARK:用户名密码label属性的设置
        self.lableName.text = "用户名"
        self.lablePassword.text = "密  码"
        self.lableName.textAlignment = NSTextAlignment.Right
        self.lablePassword.textAlignment = NSTextAlignment.Right
        self.lableName.font = UIFont.systemFontOfSize(23)
        self.lablePassword.font = UIFont.systemFontOfSize(23)
        
        //MARK:用户名密码text属性的设置
        self.textName.borderStyle = UITextBorderStyle.RoundedRect
        self.textName.placeholder = "请输入用户名"
        self.textName.returnKeyType = UIReturnKeyType.Done
        self.textName.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.textName.delegate = self
        self.textPassword.borderStyle = UITextBorderStyle.RoundedRect
        self.textPassword.placeholder = "请输入密码"
        self.textPassword.returnKeyType = UIReturnKeyType.Done
        self.textPassword.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.textPassword.secureTextEntry = true
        // self.textPassword.keyboardType = UIKeyboardType.NumberPad
        self.textPassword.delegate = self
        
        //MARK:登陆界面登陆按钮的属性设置
        self.btSubmit.setTitle("登陆", forState: UIControlState.Normal)
        self.btSubmit.addTarget(self, action: Selector("submit"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //MARK:登陆界面忘记密码按钮的属性设置
        self.btForgetPassword.setTitle("忘记密码", forState: UIControlState.Normal)
        self.btForgetPassword.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        self.btForgetPassword.enabled = false
        
        //MARK:登陆界面注册按钮的属性设置
        self.btRegister.setTitle("注册", forState: UIControlState.Normal)
        self.btRegister.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        self.btRegister.addTarget(self, action: Selector("register"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.btPage.setTitle("滚动视图", forState: UIControlState.Normal)
        self.btPage.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        self.btPage.addTarget(self, action: Selector("page"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.switch_PS.onTintColor = UIColor.grayColor()
        self.switch_PS.addTarget(self, action: Selector("switchDidChange"), forControlEvents: UIControlEvents.ValueChanged)
        
        //MARK: 增加一个按钮用于用户点击背景图片之后时键盘退出
        self.background.addTarget(self, action: Selector("cancelKeyboard"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func  cancelKeyboard()
    {
        self.textName.resignFirstResponder()
        self.textPassword.resignFirstResponder()
    }
    
    func  submit()
    {
        if  self.textName.text == "123"
        {
            if self.textPassword.text == "123"
            {
//                let sub = SegViewController()
//                sub.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
//                //self.presentViewController(sub, animated: true , completion: nil)
                //self.showViewController(loadViewController(), sender: nil )
                self.showDetailViewController(LinkViewController(), sender: nil)
                
            }
            else
            {
                let  alertView = UIAlertView(title: "提示", message: "密码错误=_=", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
            }
        }
        else
        {
            let  alertView = UIAlertView(title: "提示", message: "用户名错误=_=", delegate: self, cancelButtonTitle: "确定")
                alertView.show()
        }
    }
    
    func  switchDidChange()
    {
        if switch_PS.on
        {
            self.textPassword.secureTextEntry = false
        }
        else
        {
            self.textPassword.secureTextEntry = true
        }
    }
    
    //MARK: 实现UITextFieldDelegate协议
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textName.resignFirstResponder()
        self.textPassword.resignFirstResponder()
        return  true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if self.textName.text!.isEmpty || self.textPassword.text!.isEmpty
        {
             self.btSubmit.enabled = false
             self.btSubmit.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        }
        else
        {
            self.btSubmit.enabled = true
            self.btSubmit.backgroundColor = UIColor.orangeColor()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

