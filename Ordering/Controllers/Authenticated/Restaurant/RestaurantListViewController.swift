//
//  RestaurantsViewController.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class RestaurantListViewController: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var headerLabel : UILabel!
    var restaurants : [Restaurant]!
    var searchBar : UISearchBar = UISearchBar(frame:CGRect(x:0,y:0,width:200, height:30))
    var topOffset : CGFloat!
    var offloadFunction : ((_ restaurant: Restaurant) -> Void)?
    var restaurantNeedsLoading : Bool = false
    var locationManager = CLLocationManager()
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    init(frame: CGRect, restaurants: [Restaurant], getMenuAndNav:@escaping (_ restaurant: Restaurant)->Void) {
        //Using closure, passed a function from the parent that get executed on click!
        self.offloadFunction = getMenuAndNav
        super.init(frame:frame)
        self.restaurants = restaurants
        self.setUpView()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func refresh() {
        
    }
    
   
    
    func setUpView( ) {
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(self.tableView)
        
        headerLabel = UILabel(frame:CGRect(x:100,y:10,width:UIScreen.main.bounds.width,height:20))
        headerLabel.text = "Nearby"
        self.tableView.tableHeaderView = headerLabel
        //self.navigationItem.titleView = searchBar
        
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let rest = self.restaurants[indexPath.row]
        cell.textLabel!.text = rest.getName() +  " - " + (rest.isOpen() ? "Open":"Closed")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //getMenuAndNav(restaurant: self.restaurants[indexPath.row])
        self.offloadFunction!(self.restaurants[indexPath.row])
    }
    
    
    func getRestaurants () {
        let userLong = self.locationManager.location?.coordinate.longitude
        let userLat = self.locationManager.location?.coordinate.latitude
        RestaurantHelper.sharedInstance.getNearMe(longitude: CLLocationDegrees(userLong!), latitude: CLLocationDegrees(userLat!), onCompletion: {(restaurants: [Restaurant]?, error: NSError?) -> Void in
            if(error == nil) {
                self.restaurants = restaurants
                self.setUpView()
            }else {
                print(error! as NSError)
            }
        })
    }
    
    func refreshRestaurants ( newRestaurants: [Restaurant]){
        self.restaurants = newRestaurants
        self.tableView.reloadData()
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
