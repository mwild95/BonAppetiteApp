//
//  StartViewController.swift
//  Ordering
//
//  Created by Michael Wild on 09/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        /*Register Button*/
        let regButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.05, y: UIScreen.main.bounds.height - 60 , width: UIScreen.main.bounds.size.width * 0.45 - 10, height: 50))
        regButton.backgroundColor = .clear
        regButton.layer.borderWidth = 2
        regButton.layer.borderColor = UIColor.lightGray.cgColor
        regButton.setTitleColor(UIColor.darkGray, for: UIControlState())
        regButton.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        regButton.setTitle("Register", for: UIControlState())
        regButton.addTarget(self, action: #selector(regButtonAction), for: .touchUpInside)
        /*---------------------------------*/
        
        /*Start Button*/
        let loginButton = UIButton(frame: CGRect(x:UIScreen.main.bounds.size.width * 0.5 + 10 , y: UIScreen.main.bounds.height - 60, width: UIScreen.main.bounds.size.width * 0.45 - 10, height: 50))
        loginButton.backgroundColor = UIColor(red:0.26, green:0.53, blue:0.96, alpha:1.0)
        loginButton.setTitle("Login", for: UIControlState())
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        /*---------------------------------*/
        
        self.view.addSubview( loginButton )
        self.view.addSubview( regButton )
        self.view.layoutIfNeeded()
        
    }
    
    func regButtonAction(_ sender: UIButton!) {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func loginButtonAction( _ sender: UIButton! ) {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true )
        //self.navigationController?.present(loginViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
