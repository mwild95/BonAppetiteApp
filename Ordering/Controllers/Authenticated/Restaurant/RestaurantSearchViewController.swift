//
//  RestaurantSearchViewController.swift
//  Ordering
//
//  Created by Michael Wild on 30/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurantSearchViewController: UIViewController, UISearchBarDelegate {

    var originalRestaurants : [Restaurant] = []
    var restaurants : [Restaurant] = []
    var locationManager : CLLocationManager!
    var basketButton : UIBarButtonItem!
    lazy var searchBar : UISearchBar = UISearchBar(frame:CGRect(x:0,y:0,width:200,height:20))
    var restaurantMapViewController : RestaurantMapViewController!
    var restaurantListViewController : RestaurantListViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRestaurants()
        
        
        basketButton = UIBarButtonItem(image: UIImage(named:"BasketIcon"), style: .plain, target: self, action: #selector(basketButtonAction))
        
        navigationItem.rightBarButtonItems = [basketButton]
        // Do any additional setup after loading the view.
        
        searchBar.placeholder = "Search Restaurants"
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        self.navigationItem.titleView = searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if BasketHelper.sharedInstance.isScannedIn {
            self.scannedInToTable()
        }
    }
    
    func setupView() {
        restaurantMapViewController = RestaurantMapViewController(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4), restaurants: self.restaurants, getMenuAndNav: self.getMenuAndNav)
        
        self.view.addSubview(restaurantMapViewController)
        
        restaurantListViewController = RestaurantListViewController(frame: CGRect(x:0, y:UIScreen.main.bounds.height * 0.4,width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6), restaurants: self.restaurants, getMenuAndNav: self.getMenuAndNav)
        
        self.view.addSubview(restaurantListViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRestaurants () {
        let userLong = LocationHelper.sharedInstance.locationManager.location?.coordinate.longitude
        let userLat = LocationHelper.sharedInstance.locationManager.location?.coordinate.latitude
        RestaurantHelper.sharedInstance.getNearMe(longitude: CLLocationDegrees(userLong!), latitude: CLLocationDegrees(userLat!), onCompletion: {(restaurants: [Restaurant]?, error: NSError?) -> Void in
            if(error == nil) {
                self.restaurants = restaurants!
                self.originalRestaurants = restaurants!
                self.setupView()
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
    
    func scannedInToTable( ) {
        // teh user has used the qr code scanner and scanned themselves into a table
        //table and restaurant stored in basket helper
        let restaurantId: String = BasketHelper.sharedInstance.getRestaurantId()
        let tableNo: String = BasketHelper.sharedInstance.getTableNo()
        
        let _ : Void = RestaurantHelper.sharedInstance.getRestaurant(restaurantId: restaurantId, onCompletion: {(restaurant: Restaurant?, error: NSError?) -> Void in
            if(error == nil) {
                let restaurantView = RestaurantViewController()
                restaurantView.restaurant = restaurant
                restaurantView.tableNo = tableNo
                self.navigationController?.pushViewController(restaurantView, animated: false)
            }else {
                print(error as Any)
            }
        })
        
    }


    
    func basketButtonAction ( ) {
        
        BasketHelper.sharedInstance.navToBasket( _navController : (self.navigationController)! )
    }

    
    
    /////////Search Bar delegation
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        searchBar.frame.size.width = UIScreen.main.bounds.width
        self.navigationItem.rightBarButtonItems = []
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.frame.size.width = 200
        self.navigationItem.rightBarButtonItems = [basketButton]
        searchBar.resignFirstResponder()
        
        if(searchBar.text == "") {
            self.refreshViews(restaurantsForRefresh: self.originalRestaurants)
            self.restaurantListViewController.headerLabel.text = "Nearby"
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            print(searchBar.text!)
        }
        let userLong = LocationHelper.sharedInstance.locationManager.location?.coordinate.longitude
        let userLat = LocationHelper.sharedInstance.locationManager.location?.coordinate.latitude

        RestaurantHelper.sharedInstance.searchRestaurants(longitude: CLLocationDegrees(userLong!), latitude: CLLocationDegrees(userLat!), searchTerm: searchBar.text!, onCompletion: {(restaurants: [Restaurant]?, error: NSError?) -> Void in
            if(error == nil) {
                self.restaurants = restaurants!
                self.refreshViews(restaurantsForRefresh: restaurants!)
                self.restaurantListViewController.headerLabel.text = "Search Results"
            }else {
                print(error! as NSError)
            }
        })
    }
    
    func refreshViews( restaurantsForRefresh:[Restaurant]) {
        
        self.restaurantListViewController.refreshRestaurants(newRestaurants: restaurantsForRefresh)
        self.restaurantMapViewController.refreshRestaurants(newRestaurants: restaurantsForRefresh)
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
