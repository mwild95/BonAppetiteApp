//
//  UserHelper.swift
//  Ordering
//
//  Created by Michael Wild on 10/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class UserHelper {
    static let sharedInstance = UserHelper()
    fileprivate var currentUser : User!
    let baseUrl : String = "http://35.164.11.97:3000/api/"
    init () {
        
    }
    
    func login( _ _username : String, _password: String, onCompletion: @escaping (User?, NSError?) -> Void) -> Void {
        print("logging in: " + _username + " " + _password )
        self.currentUser = User()
        self.currentUser.setUserCredentials(_username, password: _password)
        let userJson = SerializationHelper.toDictionary(self.currentUser)
        let requestURL = self.baseUrl + "users/login"
        
        Alamofire.request( requestURL, method : .post, parameters : userJson)
            .validate(statusCode: 200..<300)
            .responseJSON {response in
                switch response.result {
                case .success:
                    let userResponse = JSON(response.result.value!)
                    self.currentUser.setUsername(userResponse["username"].string!)
                    self.currentUser.setId(userResponse["_id"].string!)
                    onCompletion(self.currentUser, nil)
                case .failure(let error):
                   
                    onCompletion(nil, error as NSError)
                }
                
                
            }
        
    }
    
    func create( _ _username : String, _password : String, _email : String, onCompletion: @escaping ( Bool?, NSError?) -> Void) -> Void {
        print("Creating User: " + _username)
        let newUserDictionary = [
            "username" : _username,
            "email" : _email,
            "password" : _password
        ]
        
        let requestURL = self.baseUrl + "/users"
        
        Alamofire.request( requestURL, method : .post, parameters: newUserDictionary )
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                switch response.result{
                case .success:
                    onCompletion(true,nil)
                case .failure(let error):
                    print(error)
                    onCompletion(false, error as NSError)
                }
            }
    }
   
    
    func getUser ( ) -> User {
        return self.currentUser
    }
    
    func setUser ( _ _user : User ) {
        self.currentUser = _user
    }

    
}
