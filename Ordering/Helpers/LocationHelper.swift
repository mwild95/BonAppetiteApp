//
//  LocationHelper.swift
//  Ordering
//
//  Created by Michael Wild on 24/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import CoreLocation


class LocationHelper{
    var locationManager: CLLocationManager!
    static var sharedInstance = LocationHelper()
    
    init ( ){
        self.locationManager = CLLocationManager()
    }
}
