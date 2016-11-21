//
//  File.swift
//  Ordering
//
//  Created by Michael Wild on 19/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation

class ProductCache {
    
    fileprivate var products : [String : Product]
    static var sharedInstance: ProductCache = ProductCache()
    
    init () {
        self.products = [String: Product]()
    }
    
    func getProduct( _productId : String ) -> Product {
        return self.products[_productId]!
    }
    
    func putProduct( _product: Product ) {
        self.products[_product.getId()] = _product
    }
    
    func putProducts ( _products: [Product]) {
        for product in _products {
            self.products[product.getId()] = product
        }
    }
}
