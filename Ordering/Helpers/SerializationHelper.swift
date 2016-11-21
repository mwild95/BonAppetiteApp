//
//  SerializationHelper.swift
//  Ordering
//
//  Created by Michael Wild on 10/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON

class SerializationHelper {

    class func toDictionary( _ user: User ) -> Dictionary<String, AnyObject>{
        return [
            "username" : NSString(string: user.getUsername()) as String as String as AnyObject,
            "password" : NSString(string: user.getPassword()) as String as String as AnyObject
        ]
    }
    
    class func toDictionary ( _ order: Order ) -> Dictionary<String, Any> {
        return [
            "products" : NSArray(array:order.getProducts()).flatMap {$0},
            "owning_user" : NSString(string: order.getOwningUser()),
            "restaurant" : NSString(string: order.getRestaurantId())
        ]
    }
}
