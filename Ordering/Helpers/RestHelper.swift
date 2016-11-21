//
//  RestHelper.swift
//  Ordering
//
//  Created by Michael Wild on 10/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RestHelper: NSObject {
    static let baseUrl : String = "http://54.71.231.16:3000/api/"
    
    
    override init () {
        super.init()
    }
    
    class func login( _ user : User, completionHandler: @escaping (_ result: User?, _ error: NSError?)->Void){
        //send a rest request off
        //return the user that was returned
        let userJson = SerializationHelper.toDictionary(user)

        Alamofire.request( baseUrl + "/users/login", method : .post, parameters : userJson)
            .validate(statusCode: 200..<300)
            .responseJSON {response in
                switch response.result {
                case .success:
                    let userResponse = JSON(response.result.value!)
                    user.setUsername(userResponse["username"].string!)
                    user.setId(userResponse["_id"].string!)
                    completionHandler(user, nil)
                case .failure(let error):
                    completionHandler(nil, error as NSError)
                }

                // 1
            //print(response.request!)  // original URL request
            //print(response.response!) // URL response
            //print(response.data!)     // server data
            //print(response.result)   // result of response serialization
            
        }
    }
}
