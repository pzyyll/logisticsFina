//
//  LoginViewWithSBController.swift
//  Second_IOS
//
//  Created by CAIZHILI on 16/3/19.
//  Copyright © 2016年 13110100224. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewWithSBController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.login.layer.borderColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5).CGColor
        self.login.layer.borderWidth = 2
        //self.login.layer.cornerRadius = 4
        self.login.setTitleColor(UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5), forState: .Disabled)
        self.login.setTitleColor(UIColor(red: 55/255, green: 168/255, blue: 122/255, alpha: 0.6), forState: .Highlighted)
        self.login.enabled = false
        
        self.username.delegate = self
        self.passwd.delegate = self
        
        let user = NSUserDefaults.standardUserDefaults().valueForKey("user") as? String
        if user != nil {
            self.username.text = user
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(sender: UIButton) {
        let user = self.username.text
        let pwd = self.passwd.text
        
        let paras = ["user": user!, "pwd": pwd!]
        GRNetWork.loginRequest(paras) { (_, _, data, er) -> Void in
            let json = JSON(data: data!)
            print(json)
            if er != nil {
                print(er)
            }
            if json["deniable"].int == 0 {
                //验证成功
                NSUserDefaults.standardUserDefaults().setObject(user, forKey: "user")
                NSUserDefaults.standardUserDefaults().setObject(pwd, forKey: "pwd")
                //self.navigationController?.popViewControllerAnimated(true)
                self.showDetailViewController(LinkViewController(), sender: nil)
            } else {
                //验证失败
                let alertView = UIAlertController(title: "Warn", message: "用户名或密码错误", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.username.resignFirstResponder()
        self.passwd.resignFirstResponder()
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //change the login button states
        if self.username.text!.isEmpty {
            self.login.enabled = false
            self.login.layer.borderColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5).CGColor
            return true
        }
        if textField.text!.isEmpty && !string.isEmpty {
            self.login.enabled = true
            self.login.layer.borderColor = UIColor(red: 55/255, green: 168/255, blue: 122/255, alpha: 0.5).CGColor
        }
        if range.location == 0 && range.length > 0 {
            self.login.enabled = false
            self.login.layer.borderColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5).CGColor
        }
        
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        login.enabled = false
        self.login.layer.borderColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5).CGColor
        return true
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
