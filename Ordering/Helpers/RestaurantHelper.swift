//
//  RestaurantHelper.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import CoreLocation

class RestaurantHelper {
    static let sharedInstance = RestaurantHelper()
    fileprivate var restaurants : [String: Any]!
    let baseUrl : String = "http://35.164.11.97:3000/api/"
    
    func getNearMe(longitude: CLLocationDegrees, latitude: CLLocationDegrees, onCompletion: @escaping ([Restaurant]?, NSError?) -> Void) -> Void {
        let requestURL = baseUrl + "restaurants/"
        Alamofire.request( requestURL, parameters: ["longitude":longitude, "latitude":latitude, "distance":500])
            .validate(statusCode: 200..<300)
            .responseJSON {response in
                switch response.result {
                case .success:
                    let restaurantsResponse = JSON([response.result.value!][0])
                    var restaurantObjs : [Restaurant] = []
                    for(_, restaurantJSON) in restaurantsResponse {
                        let restaurant : Restaurant = Restaurant(restaurantJSON: restaurantJSON);
                        restaurantObjs.append(restaurant)
                    }
                    //self.restaurants = restaurantsResponse as [String: Any]
                    onCompletion(restaurantObjs, nil)
                case .failure(let error):
                    
                    onCompletion(nil, error as NSError)
                }
                
                
        }
    }
    
    func getFullMenu(menuId : String, onCompletion: @escaping (Menu?, NSError?) -> Void ) -> Void {
        let requestURL = baseUrl + "/menus/" + menuId
        Alamofire.request( requestURL )
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let menu = Menu(menuJSON: JSON(response.result.value!))
                    onCompletion(menu, nil)
                case .failure(let error):
                    onCompletion(nil, error as NSError)
                }
        }
    }
    
    func getRestaurant( restaurantId: String, onCompletion: @escaping (Restaurant?, NSError?) -> Void ) -> Void {
        let requestURL = baseUrl + "restaurants/" + restaurantId
        Alamofire.request( requestURL )
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let restaurant = Restaurant(restaurantJSON: JSON(response.result.value!))
                    onCompletion(restaurant, nil)
                case .failure(let error):
                    onCompletion(nil, error as NSError)
                }
        
        }
    }
    
    func searchRestaurants( longitude: CLLocationDegrees, latitude: CLLocationDegrees, searchTerm: String, onCompletion: @escaping ([Restaurant]?, NSError?)-> Void) -> Void {
        let requestURL = baseUrl + "restaurants"
        Alamofire.request(requestURL, parameters: ["longitude":longitude, "latitude":latitude, "distance":50000000, "term":searchTerm])
            .validate(statusCode: 200..<300)
            .responseJSON {response in
                switch response.result {
                case .success:
                    let restaurantsResponse = JSON([response.result.value!][0])
                    var restaurantObjs : [Restaurant] = []
                    for(_, restaurantJSON) in restaurantsResponse {
                        let restaurant : Restaurant = Restaurant(restaurantJSON: restaurantJSON);
                        restaurantObjs.append(restaurant)
                    }
                    //self.restaurants = restaurantsResponse as [String: Any]
                    onCompletion(restaurantObjs, nil)
                case .failure(let error):
                    onCompletion(nil, error as NSError)
                }
        }
    }
    
}
