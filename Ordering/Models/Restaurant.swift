//
//  Restaurant.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON


class Restaurant : OwnedBy{
    
    var menu : Menu!
    
    override init () {
        super.init()
    }
    
    init(restaurantJSON: JSON)
    {
        super.init()
        self.setId(restaurantJSON["_id"].string!)
        self.setName(restaurantJSON["name"].string!)
        self.setOwningUser((restaurantJSON["owning_user"].string) ?? "")
        self.setMenu( _menu: Menu(menuJSON: restaurantJSON["menu"]) )
    }
    
    func setMenu ( _menu : Menu ) {
        self.menu = _menu;
    }
    
    func getMenu ( ) -> Menu {
        return self.menu
    }

}
