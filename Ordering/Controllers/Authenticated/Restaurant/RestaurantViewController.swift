//
//  RestaurantViewController.swift
//  Ordering
//
//  Created by Michael Wild on 14/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController{

    var restaurant : Restaurant!
    var menu : Menu!
    var topOffset : CGFloat!
    var basketButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topOffset = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.bounds.size.height)!
        
        let restaurantImage = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width*0.25),y:(topOffset + 10),width:(UIScreen.main.bounds.width / 2), height: (UIScreen.main.bounds.width / 2)))
        restaurantImage.backgroundColor = UIColor.gray
        
        
        let restaurantTitle = UILabel(frame: CGRect(x:0,y:(topOffset + 10 + restaurantImage.frame.height + 10) ,width:200,height:21))
        
        restaurantTitle.text = restaurant.getName()
        restaurantTitle.sizeToFit()
        restaurantTitle.frame.origin.x = (UIScreen.main.bounds.width / 2) - (restaurantTitle.bounds.width / 2)
       
        
        let viewMenuBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.1, y: restaurantTitle.frame.origin.y + restaurantTitle.bounds.height + 10 , width: UIScreen.main.bounds.size.width * 0.8, height: UIButton.defaultHeight()))
        viewMenuBtn.defaultStyle()
        viewMenuBtn.setTitle("View Menu", for: UIControlState())
        viewMenuBtn.addTarget(self, action: #selector(viewMenuButtonAction), for: .touchUpInside)
        
        
        //self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = restaurant.getName()
        self.view.addSubview(restaurantTitle)
        self.view.addSubview(restaurantImage)
        self.view.addSubview(viewMenuBtn)
        
        basketButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(basketButtonAction))
        
        navigationItem.rightBarButtonItems = [basketButton]
       
        
    }
    
    func basketButtonAction () {
        BasketHelper.sharedInstance.navToBasket( _navController : self.navigationController!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = restaurant.getName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewMenuButtonAction(_ sender: UIButton!) {
        let sectionListController = SectionListViewController()
        sectionListController.menu = restaurant.getMenu()
        self.navigationController?.pushViewController(sectionListController, animated: true)
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
