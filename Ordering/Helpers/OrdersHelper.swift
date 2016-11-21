//
//  OrdersHelper.swift
//  Ordering
//
//  Created by Michael Wild on 18/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OrdersHelper {
    static let sharedInstance = OrdersHelper()
    let baseUrl : String = "http://35.164.11.97:3000/api/"
    
    init() {}
    
    
    func sendOrder ( _owning_user : String, _products: [String], _restaurantId : String, onCompletion: @escaping (Order?, NSError?) -> Void ) -> Void {
        var orderToSend = Order(_owning_user: _owning_user, restaurantId: _restaurantId, _products : _products)
        let orderJson = SerializationHelper.toDictionary(orderToSend)
        print(orderJson)
        let requestURL = self.baseUrl + "/orders"
        
        Alamofire.request( requestURL, method: .post, parameters: orderJson, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON {response in
                switch response.result {
                case .success:
                    let orderResponse = JSON(response.result.value!)
                    onCompletion(nil, nil)
                case .failure(let error):
                    print(error)
                    onCompletion(nil, error as NSError)
                }
        }
    }

}
 
