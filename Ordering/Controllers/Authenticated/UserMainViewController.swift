//
//  CustomTabBar.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class UserMainViewController: UITabBarController, UITabBarControllerDelegate {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
               // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear( _ animated : Bool ) {
        super.viewWillAppear( animated)
        
        
        let profileViewController = ProfileViewController()
        //let profileTabIcon = UITabBarItem(tabBarSystemItem:UITabBarSystemItem.recents, tag: 0)
        let profileTabIcon = UITabBarItem(title: "Profile", image: UIImage(named :"ProfileIcon"), tag: 5)
        profileViewController.tabBarItem = profileTabIcon
        
        let favouritesViewController = FavouritesViewController()
        let favouritesTabIcon = UITabBarItem(tabBarSystemItem:UITabBarSystemItem.favorites, tag: 4)
        favouritesViewController.tabBarItem = favouritesTabIcon
        
        
        let restaurantsTabIcon = UITabBarItem(title: "Restaurants", image: UIImage(named :"ProfileIcon"), tag: 5)
        
        let restaurantSearchViewController = RestaurantSearchViewController()
        //let restaurantViewController = RestaurantViewController()
        let restaurantHeirachy = [restaurantSearchViewController]
        
        let restaurantNavController = UINavigationController(rootViewController: restaurantSearchViewController)
        restaurantNavController.viewControllers = restaurantHeirachy
        
        restaurantNavController.tabBarItem = restaurantsTabIcon
        restaurantNavController.popToRootViewController(animated: true)
        
        
        let qrPlaceholderViewController = QRPlaceholderViewController()
        let qrStack = [qrPlaceholderViewController]
        let qrNavController = UINavigationController(rootViewController: qrPlaceholderViewController)
        let qrScannerTabIcon = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.search, tag: 6)
        qrNavController.tabBarItem = qrScannerTabIcon
        qrNavController.viewControllers = qrStack
        
        let controllers = [restaurantNavController,favouritesViewController, qrNavController, profileViewController]
        self.viewControllers = controllers
        
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
