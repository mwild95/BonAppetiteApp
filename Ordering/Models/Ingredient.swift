//
//  Ingredient.swift
//  Ordering
//
//  Created by Michael Wild on 01/12/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON

class Ingredient: OwnedBy {
    override init ( ) {
        super.init()
    }
    
    init ( _ingredientJSON: JSON ) {
        super.init()
        self.setOwningUser(_ingredientJSON["owning_user"].string!)
        self.setId(_ingredientJSON["_id"].string!)
        self.setName(_ingredientJSON["name"].string!)
    }
}
