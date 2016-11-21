//
//  RestaurantsViewController.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit
import SwiftyJSON

class RestaurantListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var restaurants : [Restaurant]!
    var searchBar : UISearchBar = UISearchBar(frame:CGRect(x:0,y:0,width:200, height:30))
    var topOffset : CGFloat!
    var basketButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topOffset = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.bounds.size.height)!
        //self.searchBar.placeholder = "Search Restaurants"
        //self.searchBar.showsCancelButton = true
        //searchBar.sizeToFit()
        
        getRestaurants()
    }
    
    func setUpView( ) {
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        self.navigationItem.hidesBackButton = true
        //self.navigationItem.titleView = searchBar
        
        basketButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(basketButtonAction))
        
        navigationItem.rightBarButtonItems = [basketButton]

    }
    
    func basketButtonAction ( ) {
        
        BasketHelper.sharedInstance.navToBasket( _navController : (self.navigationController)! )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let rest = self.restaurants[indexPath.row]
        cell.textLabel!.text = rest.getName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getMenuAndNav(restaurant: self.restaurants[indexPath.row])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getRestaurants () {
        RestaurantHelper.sharedInstance.getNearMe(onCompletion: {(restaurants: [Restaurant]?, error: NSError?) -> Void in
            if(error == nil) {
                self.restaurants = restaurants
                self.setUpView()
            }else {
                print(error! as NSError)
            }
        })
    }
    
    func getMenuAndNav ( restaurant: Restaurant ) {
        RestaurantHelper.sharedInstance.getFullMenu(menuId: restaurant.getMenu().getId(), onCompletion:{(menu:Menu?, error: NSError?) -> Void in
            if(error == nil){
                let restaurantView = RestaurantViewController()
                restaurant.setMenu(_menu: menu!)
                restaurantView.restaurant = restaurant
                BasketHelper.sharedInstance.setRestaurantId(_restaurantId: restaurant.getId())
                self.navigationController?.pushViewController(restaurantView, animated: true)
            }else {
                print(error! as NSError)
            }
        })
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
