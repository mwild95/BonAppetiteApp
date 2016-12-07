//
//  FavouritesViewController.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIView, MKMapViewDelegate {
    
    var mapView : MKMapView!
    var restaurants : [Restaurant]!
    var locationManager : CLLocationManager!
    var offloadFunction : ((_ restaurant: Restaurant) -> Void)?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.initializeMap(restaurants: self.restaurants, locationManager: self.locationManager, frame: frame)
    }
    
    init(frame: CGRect, restaurants: [Restaurant], getMenuAndNav:@escaping (_ restaurant: Restaurant)->Void){
        self.offloadFunction = getMenuAndNav
        super.init(frame: frame)
        self.initializeMap(restaurants: restaurants, locationManager: LocationHelper.sharedInstance.locationManager, frame: frame)
    }
    
    required init(coder: NSCoder){
        super.init(coder: coder)!
    }
    
    func initializeMap ( restaurants: [Restaurant], locationManager : CLLocationManager, frame: CGRect) {
        self.restaurants = restaurants
        self.locationManager = locationManager
        mapView = MKMapView(frame: frame)
        mapView.delegate = self
        self.addSubview(mapView)
        
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
        for restaurant in restaurants {
            addPin(longitude: CLLocationDegrees(restaurant.getLongitude()), latitude: CLLocationDegrees(restaurant.getLatitude()), restaurant: restaurant)
        }
        
        //getRestaurants()
        // Do any additional setup after loading the view.
    }
    
    
    func addPin ( longitude : CLLocationDegrees, latitude : CLLocationDegrees, restaurant: Restaurant ) {
        let pinToAdd = RestaurantPinAnnotation()
        pinToAdd.setRestaurant(restaurant: restaurant)
        pinToAdd.setCoordinate(longitude: longitude, latitude: latitude)
        pinToAdd.title = restaurant.getName()
        mapView.addAnnotation(pinToAdd)
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is RestaurantPinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            //pinAnnotationView.pinTintColor = .blue
            
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            //let viewButton = UIButton(type : UIButtonType.custom) as UIButton
            let viewButton = UIButton(type: UIButtonType.detailDisclosure) as UIButton
            viewButton.frame.size.width = 44
            viewButton.frame.size.height = 44
            pinAnnotationView.rightCalloutAccessoryView = viewButton
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? RestaurantPinAnnotation {
            self.offloadFunction!(annotation.getRestaurant())
        }
    }
    
    func refreshRestaurants ( newRestaurants: [Restaurant]) {
        self.restaurants = newRestaurants
        self.mapView.removeAnnotations(self.mapView.annotations)
        for restaurant in restaurants {
            addPin(longitude: CLLocationDegrees(restaurant.getLongitude()), latitude: CLLocationDegrees(restaurant.getLatitude()), restaurant: restaurant)
        }
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
