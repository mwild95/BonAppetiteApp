//
//  NameCarrier.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation


class NameCarrier: IdCarrier{
    var name : String!
    
    override init () {
        super.init()
    }
    
    func setName ( _ _name : String ) {
        self.name = _name
    }
    
    func getName ( ) -> String {
        return self.name
    }
}
