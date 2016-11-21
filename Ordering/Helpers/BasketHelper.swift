//
//  BasketHelper.swift
//  Ordering
//
//  Created by Michael Wild on 18/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import UIKit

class BasketHelper {
    static let sharedInstance = BasketHelper()
    fileprivate var products : [String] = []
    fileprivate var restaurantId : String = ""
    
    fileprivate var basketViewController: BasketViewController = BasketViewController()
    
    init ( ){
    
    }
    
    func addToBasket ( _productToAddId : String ) {
        self.products.append( _productToAddId )
    }
    
    func getBasket ( ) -> [Product] {
        var productObjects : [Product] = []
        for productId in products {
            productObjects.append(ProductCache.sharedInstance.getProduct(_productId: productId))
        }
        return productObjects
    }
    
    func getBasketAsStrings ( ) -> [String] {
        return self.products
    }
    
    func getSubTotal ( ) -> Double {
        var runningTotal = 0.0
        for productId in products {
            runningTotal += ProductCache.sharedInstance.getProduct(_productId: productId).getPrice()
        }
        return runningTotal
    }
    
    func removeFromBasket ( _productIdToRemove : String ) -> Bool {
        for (index, element) in products.enumerated() {
            if( element == _productIdToRemove ) {
                products.remove(at: index)
                return true
            }
        }
        //product was not found
        return false
    }
    
    func navToBasket ( _navController : UINavigationController ) {
        _navController.pushViewController(basketViewController, animated: true)
    }
    
    func setRestaurantId ( _restaurantId : String ) {
        self.restaurantId = _restaurantId
    }
    
    func getRestaurantId ( ) -> String {
        return self.restaurantId
    }
}
