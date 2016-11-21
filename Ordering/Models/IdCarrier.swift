//
//  IdCarrier.swift
//  Ordering
//
//  Created by Michael Wild on 11/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class IdCarrier {
    var _id : String!
    
    init () {
    
    }
    
    func setId ( _ _id : String ) {
        self._id = _id
    }
    
    func getId ( ) -> String {
        return self._id
    }
}
