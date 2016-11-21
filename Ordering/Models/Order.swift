//
//  Order.swift
//  Ordering
//
//  Created by Michael Wild on 19/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation

class Order : OwnedBy {
    
    var products : [String] = []
    var restaurant : String = ""
    
    override init ( ) {
        super.init()
    }
    
    init ( _owning_user: String, restaurantId : String, _products: [String]) {
        super.init()
        self.setOwningUser(_owning_user)
        self.setRestaurantId( _restaurantId: restaurantId)
        self.setProducts(_products: _products)
    }
    
    func setRestaurantId ( _restaurantId : String ) {
        self.restaurant = _restaurantId
    }
    
    func getRestaurantId ( ) -> String {
        return self.restaurant
    }
    
    func setProducts ( _products : [String] ) {
        self.products = _products
    }
    
    func getProducts ( ) -> [String] {
        return self.products;
    }
}
