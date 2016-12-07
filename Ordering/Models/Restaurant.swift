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
    var longitude : Double!
    var latitude : Double!
    var openingTimes : [OpeningTime] = []
    
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
        self.longitude = restaurantJSON["loc"][0].double ?? 0.0
        self.latitude = restaurantJSON["loc"][1].double ?? 0.0
        self.setOpeningTimes(_openingTimes: restaurantJSON["opening_times"].array!)
    }
    
    func setMenu ( _menu : Menu ) {
        self.menu = _menu;
    }
    
    func getMenu ( ) -> Menu {
        return self.menu
    }
    
    func getLongitude ( ) -> Double {
        return self.longitude;
    }
    
    func getLatitude ( ) -> Double {
        return self.latitude;
    }
    
    func setOpeningTimes( _openingTimes: [JSON] ) {
        for openingTime in _openingTimes {
            if(openingTime.type == .dictionary ) {
                let tempObj = OpeningTime(openingTimeJSON: openingTime)
                self.openingTimes.append(tempObj)
            }
            
        }
    }

    
    func isOpen( ) -> Bool {
        let today = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.weekday], from: today)
        let dayString = convertDayNumToString(_dayNum: components.weekday!)
        var isOpen = false
        for openingTime in self.openingTimes {
            for day in openingTime.getDays() {
                if day == dayString {
                    //the day is open, but need to check time
                    isOpen = checkIsOpen(openTime: openingTime.getOpenTime(), closeTime: openingTime.getCloseTime())
                    break
                    
                    
                }
            }
        }
        return isOpen
    }
    
    private func checkIsOpen (openTime: Date, closeTime: Date) -> Bool {
        var isOpen = false
        let today = Date()
        let calendar = NSCalendar.current
        let todayComponents = calendar.dateComponents([.hour, .minute], from: today)
        
        let openComponents = calendar.dateComponents([.hour,.minute], from: openTime)
        let closeComponents = calendar.dateComponents([.hour,.minute], from: closeTime)
        //check it is after the open time
        
        let openMins = (openComponents.hour! * 60) + openComponents.minute!
        let closeMins = (closeComponents.hour! * 60) + closeComponents.minute!
        let currentMins = (todayComponents.hour! * 60) + todayComponents.minute!
        
        
        if currentMins >= openMins || currentMins <= closeMins {
            // Open
            isOpen = true
        } else {
            // Closed
        }
        
        return isOpen
    }
    
    private func convertDayNumToString( _dayNum: Int ) -> String{
        switch _dayNum{
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
}
