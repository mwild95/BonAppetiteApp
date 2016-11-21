//
//  User.swift
//  Ordering
//
//  Created by Michael Wild on 10/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation

class User : IdCarrier{
    fileprivate var username : String!
    fileprivate var password : String!
    
    override init () {
        super.init()
    }
    
    func setUserCredentials( _ username : String, password : String ) {
        self.username = username
        self.password = password
        self._id = ""
    }
    
    func getUsername ( ) -> String{
        return self.username
    }
    
    func setUsername ( _ _username : String ) {
        self.username = _username
    }
    
    
    func getPassword ( ) -> String{
        return self.password
    }

}
