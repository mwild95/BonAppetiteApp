//
//  RestaurantPinAnnotation.swift
//  Ordering
//
//  Created by Michael Wild on 30/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit
import MapKit

class RestaurantPinAnnotation: NSObject, MKAnnotation {
    private var coord : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:0, longitude:0)
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var title: String? = ""
    var subtitle: String? = ""
    var restaurant : Restaurant! = nil
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
    
    func setCoordinate( longitude: CLLocationDegrees, latitude: CLLocationDegrees){
        self.coord.latitude = latitude
        self.coord.longitude = longitude
    }
    
    func setRestaurant( restaurant: Restaurant ) {
        self.restaurant = restaurant
    }
    func getRestaurant () -> Restaurant {
        return self.restaurant
    }
}
