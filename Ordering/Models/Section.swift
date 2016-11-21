//
//  Section.swift
//  Ordering
//
//  Created by Michael Wild on 14/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON

class Section : OwnedBy{

    var products : [Product] = []
    
    override init ( ) {
        super.init()
    }
    
    init ( sectionJSON : JSON ) {
        super.init()
        self.setId(sectionJSON["_id"].string!)
        self.setName(sectionJSON["name"].string!)
        self.setOwningUser((sectionJSON["owning_user"].string) ?? "")
        self.setProducts(_products: sectionJSON["products"].array!)
    }
    
    func setProducts ( _products : [JSON] ) {
        for product in _products {
            if(product.type != Type.string ){
                let tempObj = Product(productJSON: product)
                self.products.append(tempObj)
            }
            
        }
    }
    
    func getProducts ( ) -> [Product] {
        return self.products
    }
}
