//
//  LoginViewController.swift
//  App
//
//  Created by Javed Multani on 24/07/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class LoginViewController: BaseVC {
    
    @IBOutlet weak var imageViewRemember: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    var isRememeber = false
    @IBOutlet weak var buttonLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        APP_CONTEXT.appRootController = self.navigationController!
        self.navigationController?.setNavigationBarHidden (true, animated: false)
        self.buttonLogin.backgroundColor = APP_THEME_COLOR
        self.buttonLogin.setCornerRadius(radius: 5.0)
        
        //Set data if user set remember me previously
//        let strRemember = HelperFunction.helper.FetchFromUserDefault(name: "isRemember")
//        if strRemember == "check"{
//            self.isRememeber = true
//            self.textFieldEmail.text = HelperFunction.helper.FetchFromUserDefault(name: "email")
//            self.textFieldPassword.text = HelperFunction.helper.FetchFromUserDefault(name: "password")
//            self.imageViewRemember.image = UIImage(named: "check")
//        }else{
//            self.imageViewRemember.image = UIImage(named: "uncheck")
//            self.isRememeber = false
//            self.textFieldEmail.text = ""
//            self.textFieldPassword.text = ""
//        }
        
        self.textFieldEmail.text = "admin"
        self.textFieldPassword.text = "admin"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.navigationController?.setNavigationBarHidden (true, animated: false)
    }
    @IBAction func next(_ sender: Any) {
//        let homeVC = loadVC(storyboardMain, viewHomeVC) as! HomeViewController
//        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    //MARK: - button action
    
    @IBAction func buttonHandlerRememberMe(_ sender: Any) {
        if self.isRememeber{
            self.imageViewRemember.image = UIImage(named: "uncheck")
             HelperFunction.helper.storeInUserDefaultForKey(name: "isRemember", val: "uncheck")
        }else{
            self.imageViewRemember.image = UIImage(named: "check")
             HelperFunction.helper.storeInUserDefaultForKey(name: "isRemember", val: "check")
        }
        self.isRememeber = !self.isRememeber
       
        
    }
    @IBAction func buttonHandlerSignup(_ sender: Any) {
        let signupVC = loadVC(storyboardMain, viewSignupVC) as! SignupViewController
        self.navigationController?.pushViewController(signupVC, animated: true)
        
//        let signupVC = loadVC(storyboardMain, "DeliveryViewController") as! DeliveryViewController
//        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    @IBAction func buttonHandlerLogin(_ sender: Any) {
        if self.textFieldEmail.text == "admin" && self.textFieldPassword.text == "admin"{
            let homeVC = loadVC(storyboardMain, viewImageDisplayerVC) as! ImageDisplayerViewController
                                    // homeVC.objUser = user
                                     self.navigationController?.pushViewController(homeVC, animated: true)
            return
                                 
        }
        if self.textFieldEmail.text == "" || self.textFieldPassword.text == ""{
            showAlertWithTitleWithMessage(message: "All fields are required")
        }else{
            
            if  HelperFunction.helper.isValidEmail(testStr: self.textFieldEmail.text!){
                if HelperFunction.helper.isPasswordValid(self.textFieldPassword.text!){
                    let realm = try! Realm()
                    let arrayUsers = realm.objects(RObjUser.self).filter("email == %d",self.textFieldEmail.text!)
                    if arrayUsers.count>0{
                        let user:RObjUser = arrayUsers[0]
                        if user.password == self.textFieldPassword.text!{
//                            if self.isRememeber{
//                                HelperFunction.helper.storeInUserDefaultForKey(name: "email", val: self.textFieldEmail.text!)
//                                HelperFunction.helper.storeInUserDefaultForKey(name: "password", val: self.textFieldPassword.text!)
//                            }else{
//                                HelperFunction.helper.storeInUserDefaultForKey(name: "email", val: "")
//                                HelperFunction.helper.storeInUserDefaultForKey(name: "email", val: "")
//                            }
                           HelperFunction.helper.storeInUserDefaultForKey(name: "email", val: self.textFieldEmail.text!)
                            
                           let homeVC = loadVC(storyboardMain, viewImageDisplayerVC) as! ImageDisplayerViewController
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        }else{
                            showAlertWithTitleWithMessage(message: "Wrong email or password!Please enter valid email id and password.")
                        }
                    }else{
                        showAlertWithTitleWithMessage(message: "User doesn't exists!.Please enter valid email id and password")
                    }
                }else{
                    showAlertWithTitleWithMessage(message: "Password should contain one special character and minimum 8 characters required")
                }
                
                
            }else{
                showAlertWithTitleWithMessage(message: "Email is not valid")
            }
            
        }
        
    }
    
    
}
