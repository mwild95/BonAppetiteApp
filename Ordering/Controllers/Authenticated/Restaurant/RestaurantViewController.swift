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
    var tableNo: String = ""
    var scannedInLabel : UILabel!
    var checkoutConfirmation : UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.topOffset = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.bounds.size.height)!
        
        let restaurantImage = UIImageView(frame: CGRect(x:(UIScreen.main.bounds.width*0.25),y:(topOffset + 30 + 49),width:(UIScreen.main.bounds.width / 2), height: (UIScreen.main.bounds.width / 2)))
        restaurantImage.backgroundColor = UIColor.gray
        restaurantImage.image = UIImage(named: "TestRestaurantLogo")
        
        
        let restaurantTitle = UILabel(frame: CGRect(x:0,y:(topOffset + 30 + 49 + restaurantImage.frame.height + 10) ,width:200,height:21))
        
        restaurantTitle.text = restaurant.getName()
        restaurantTitle.sizeToFit()
        restaurantTitle.frame.origin.x = (UIScreen.main.bounds.width / 2) - (restaurantTitle.bounds.width / 2)
       
        
        let viewMenuBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.1, y: restaurantTitle.frame.origin.y + 49 + restaurantTitle.bounds.height + 30 , width: UIScreen.main.bounds.size.width * 0.8, height: UIButton.defaultHeight()))
        viewMenuBtn.defaultStyle()
        viewMenuBtn.setTitle("View Menu", for: UIControlState())
        viewMenuBtn.addTarget(self, action: #selector(viewMenuButtonAction), for: .touchUpInside)
        
        
        
        checkoutConfirmation = UIAlertController(title:"Leave this table?", message:"Leaving this table will empty your basket! Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        checkoutConfirmation.addAction(UIAlertAction(title:"Leave Table", style:UIAlertActionStyle.default, handler: scanOutFromRestaurant))
        
        checkoutConfirmation.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.default, handler: nil))
    
        
        
        //self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = restaurant.getName()
        self.view.addSubview(restaurantTitle)
        self.view.addSubview(restaurantImage)
        self.view.addSubview(viewMenuBtn)
        
        self.view.addSubview(makeScannedInLabelView())
        
        
        
        basketButton = UIBarButtonItem(image: UIImage(named:"BasketIcon"), style: .plain, target: self, action: #selector(basketButtonAction))
        
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
        sectionListController.forRest = restaurant.getId()
        self.navigationController?.pushViewController(sectionListController, animated: true)
    }
    
    func scanOutFromRestaurant ( _ alert: UIAlertAction! ) {
        //user wants to scan out from restaurant
        //tell them their basket will be emptied
        BasketHelper.sharedInstance.scanOut()
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func scanOutFromRestaurantConfirmation (  ) {
        self.present(checkoutConfirmation, animated: true, completion: nil)
    }
    
    func loadScanner(  ){
        self.tabBarController?.selectedIndex = 2
    }
    
    func makeScannedInLabelView () -> UIView {
        let barBackground = UIView(frame:CGRect(x:0,y:topOffset, width:UIScreen.main.bounds.width, height:49))
        scannedInLabel = UILabel(frame:CGRect(x:10,y:10, width:0, height:20))
        if tableNo != "" {
            scannedInLabel.text = "Table \(tableNo)"
        } else {
            scannedInLabel.text = "Not at a table"
        }
        
        scannedInLabel.sizeToFit()
        scannedInLabel.textColor = .black
        barBackground.addSubview(scannedInLabel)
        
        let scanOutBtn = UIButton(frame:CGRect(x:0,y:0,width:0,height:0))
        
        if(tableNo != ""){
            scanOutBtn.addTarget(self, action: #selector(scanOutFromRestaurantConfirmation), for: .touchUpInside)
            scanOutBtn.setTitle("Leave Table", for: UIControlState())
        } else {
            scanOutBtn.addTarget(self, action: #selector(loadScanner), for: .touchUpInside)
            scanOutBtn.setTitle("Scan In", for: UIControlState())
        }
        
       
        
        scanOutBtn.setTitleColor(.black, for: .normal)
        scanOutBtn.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
        scanOutBtn.sizeToFit()
        scanOutBtn.frame.origin.x = UIScreen.main.bounds.width - scanOutBtn.frame.width - 10
        barBackground.addSubview(scanOutBtn)
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: barBackground.frame.size.height - width, width:  barBackground.frame.size.width, height: barBackground.frame.size.height)
        
        border.borderWidth = width
        
        barBackground.layer.addSublayer(border)
        barBackground.clipsToBounds = true
        barBackground.backgroundColor = .white
        
        scanOutBtn.center.y = 24.5
        scannedInLabel.center.y = 24.5
       // barBackground.backgroundColor = UIColor.lightGray
        return barBackground
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
