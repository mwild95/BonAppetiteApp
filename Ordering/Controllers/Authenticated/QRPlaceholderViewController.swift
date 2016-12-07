//
//  QRPlaceholderViewController.swift
//  Ordering
//
//  Created by Michael Wild on 22/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class QRPlaceholderViewController: UIViewController {
    
    var qrCodeScanned: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
                // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let qrScannerViewController = QRScannerViewController()
        qrScannerViewController.presentedBy = self
        
        let qrNavController = UINavigationController()
        qrNavController.viewControllers = [qrScannerViewController]
        
        self.navigationController?.present(qrNavController, animated:true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        self.qrCodeScanned = true
        let restaurantNavController = self.tabBarController?.viewControllers?[0] as! UINavigationController
        restaurantNavController.popToRootViewController(animated: true)
        BasketHelper.sharedInstance.isScannedIn = true
        self.tabBarController?.selectedIndex = 0
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
