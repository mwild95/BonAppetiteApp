//
//  LoginViewController.swift
//  Ordering
//
//  Created by Michael Wild on 09/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {

    var usernameTxt : UITextField!
    var passwordTxt : UITextField!
    var loginFailedAlert : UIAlertController!
    var usernameOrPasswordAlert : UIAlertController!
    var activityIndicator : UIActivityIndicatorView!
    var signInButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.view.backgroundColor = UIColor.white
        
        usernameTxt = UITextField(frame:CGRect(x:UIScreen.main.bounds.size.width * 0.05, y:(self.navigationController?.navigationBar.bounds.size.height)! + 10 + UIApplication.shared.statusBarFrame.size.height, width:UIScreen.main.bounds.size.width * 0.9, height:31))
        usernameTxt.placeholder = " Username"
        usernameTxt.clearButtonMode = UITextFieldViewMode.whileEditing
        usernameTxt.standardStyle()
        usernameTxt.autocorrectionType = .no
        usernameTxt.autocapitalizationType = .none
        usernameTxt.delegate = self

        
        passwordTxt = UITextField(frame:CGRect(x:UIScreen.main.bounds.size.width * 0.05, y:(self.navigationController?.navigationBar.bounds.size.height)! + 10 + UIApplication.shared.statusBarFrame.size.height + 41, width:UIScreen.main.bounds.size.width * 0.9, height:31))
        
        passwordTxt.placeholder = " Password"
        passwordTxt.clearsOnBeginEditing = true
        passwordTxt.isSecureTextEntry = true
        passwordTxt.standardStyle()
        passwordTxt.delegate = self
        
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.darkGray
        
        /*Navigation Bar Buttons*/
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        navigationItem.leftBarButtonItems = [cancelButton]
        
        signInButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(signInButtonAction))
        
        navigationItem.rightBarButtonItems = [signInButton]
        /*----------------------------------*/
        
       
        
        loginFailedAlert = UIAlertController(title:"Login Failed", message:"Your login credentials did not match.", preferredStyle: UIAlertControllerStyle.alert)
        loginFailedAlert.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler: nil))
        loginFailedAlert.addAction(UIAlertAction(title:"Forgot password?", style:UIAlertActionStyle.default, handler: forgotPasswordHandler))
        
        usernameOrPasswordAlert = UIAlertController(title:"Enter credentials", message: "Please enter your username and password.", preferredStyle: .alert)
        usernameOrPasswordAlert.addAction(UIAlertAction(title:"Ok", style:.default, handler: nil))
        
        
        //Removing navigation bar border
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.view.addSubview(usernameTxt)
        self.view.addSubview(passwordTxt)
        self.view.addSubview(activityIndicator)
        
        self.usernameTxt.becomeFirstResponder()
    }
    
    
    func cancelButtonAction( _ sender: UIBarButtonItem ) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
    func signInButtonAction( _ sender: UIBarButtonItem ) {
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)

        
        if(usernameTxt.text == nil || usernameTxt.text == "" || passwordTxt.text == nil || passwordTxt.text == ""){
            
            self.present(usernameOrPasswordAlert, animated: true, completion: nil)
            
            
            self.navigationItem.rightBarButtonItems = [signInButton]
        } else {
            let _ : Void = UserHelper.sharedInstance.login(usernameTxt.text!,_password: passwordTxt.text!, onCompletion: {(user: User?, error: NSError?) -> Void in
                if(error == nil) {
                    //let profileViewController = ProfileViewController()
                    let tabBar = UserMainViewController()
                    self.navigationController?.navigationBar.isHidden = true
                                       self.navigationController?.pushViewController(tabBar, animated: true)
                    
                }else {
                        
                    self.present(self.loginFailedAlert, animated:true, completion:nil)
                    
                    self.navigationItem.rightBarButtonItems = [self.signInButton]
                }
            })
            

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func forgotPasswordHandler ( _ alert: UIAlertAction! ) {
        print("forgot password")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameTxt {
            self.passwordTxt.becomeFirstResponder()
        } else if textField == self.passwordTxt {
            self.signInButtonAction(self.signInButton)
        }
        
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
