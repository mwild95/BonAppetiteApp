//
//  ProfileViewController.swift
//  Ordering
//
//  Created by Michael Wild on 09/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var logoutBtn : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manageButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.05, y: (self.navigationController?.navigationBar.bounds.size.height)! + UIApplication.shared.statusBarFrame.size.height + 10 , width: UIScreen.main.bounds.size.width * 0.45 - 10, height: UIButton.defaultHeight()))
        manageButton.backgroundColor = .clear
        manageButton.setTitleColor(UIColor.darkGray, for: UIControlState())
        manageButton.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        manageButton.setTitle("My Account", for: UIControlState())
        manageButton.addTarget(self, action: #selector(manageButtonAction), for: .touchUpInside)

        let ordersButton = UIButton(frame:CGRect(x: UIScreen.main.bounds.size.width * 0.05, y: (self.navigationController?.navigationBar.bounds.size.height)! + UIApplication.shared.statusBarFrame.size.height + 10 + (UIButton.defaultHeight() + 10), width: UIScreen.main.bounds.size.width * 0.45 - 10, height: UIButton.defaultHeight()))
        ordersButton.backgroundColor = .clear
        ordersButton.setTitleColor(UIColor.darkGray, for: UIControlState())
        ordersButton.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        ordersButton.setTitle("Orders", for: UIControlState())
        
        self.view.addSubview(manageButton)
        self.view.addSubview(ordersButton)
        
        logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonAction))
        
        
        
        navigationItem.rightBarButtonItems = [logoutBtn]
    }
    
    func manageButtonAction ( _ sender: UIButton! ) {
        print("manage profile selected")
        //currently this logs user out
        //need to actually do .logout()
         _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func logoutButtonAction() {
       
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
