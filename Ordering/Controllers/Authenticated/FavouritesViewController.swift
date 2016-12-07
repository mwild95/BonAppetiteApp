//
//  FavouritesViewController.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit
import MapKit

class FavouritesViewController: UIViewController, CLLocationManagerDelegate {

    var mapView : MKMapView!
    var restaurants : [Restaurant] = []
    var locationManager : CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.view.addSubview(mapView)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        /*if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
        } else {
            print("Location services are not enabled")
            locationManager.requestAlwaysAuthorization()
        }*/
        LocationHelper.sharedInstance.locationManager.requestAlwaysAuthorization()
        LocationHelper.sharedInstance.locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        let center = CLLocationCoordinate2D(latitude: (LocationHelper.sharedInstance.locationManager.location?.coordinate.latitude)!, longitude: (LocationHelper.sharedInstance.locationManager.location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        
        mapView.setRegion(region, animated: true)
        
        
        getRestaurants()
        // Do any additional setup after loading the view.
    }

    
    func addPin ( longitude : CLLocationDegrees, latitude : CLLocationDegrees, title: String ) {
        let pinToAdd = MKPointAnnotation()
        pinToAdd.title = title;
        pinToAdd.coordinate.longitude = longitude
        pinToAdd.coordinate.latitude = latitude
        
        mapView.addAnnotation(pinToAdd)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("permissions changed")
    }
    
    func getRestaurants () {
        let userLongitude = self.locationManager.location?.coordinate.longitude
        let userLatitude = self.locationManager.location?.coordinate.latitude
        RestaurantHelper.sharedInstance.getNearMe(longitude: userLongitude!, latitude: userLatitude!, onCompletion: {(restaurants: [Restaurant]?, error: NSError?) -> Void in
            if(error == nil) {
                self.restaurants = restaurants!
                for restaurant in self.restaurants {
                    self.addPin(longitude: CLLocationDegrees(restaurant.getLongitude()), latitude: CLLocationDegrees(restaurant.getLatitude()), title: restaurant.getName())
                }
            }else {
                print(error! as NSError)
            }
        })
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
