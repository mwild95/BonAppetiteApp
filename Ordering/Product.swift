//
//  Product.swift
//  Ordering
//
//  Created by Michael Wild on 14/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product : OwnedBy{
    
    var price : Double = 0
    var description : String!
    var ingredients : [Ingredient] = []
    
    override init ( ) {
        super.init()
    }
    
    init ( productJSON : JSON ) {
        super.init()
        self.setId(productJSON["_id"].string!)
        self.setName(productJSON["name"].string!)
        self.setOwningUser((productJSON["owning_user"].string) ?? "")
        self.setPrice( _price : (productJSON["price"].double!))
        self.setDescription(_description: (productJSON["description"].string) ?? "")
        self.setIngredients(_ingredients: productJSON["ingredients"].array!)
    }
    
    func setPrice ( _price: Double ) {
        self.price = _price
    }
    
    func getPrice ( ) -> Double {
        return self.price
    }
    
    func setDescription ( _description : String ) {
        self.description = _description
    }
    
    func getDescription ( ) -> String {
        return self.description
    }
    
    func setIngredients( _ingredients: [JSON] ) {
        for ingredient in _ingredients {
            self.ingredients.append(Ingredient(_ingredientJSON: ingredient))
        }
    }
}
