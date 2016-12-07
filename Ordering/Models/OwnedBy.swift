//
//  OwnedBy.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation

class OwnedBy : NameCarrier {
    
    var owning_user : String!
    
    override init () {
        super.init()
    }
    
    func setOwningUser ( _ _owning_user : String ) {
        self.owning_user = _owning_user
    }
    
    func getOwningUser ( ) -> String {
        return self.owning_user
    }

}
