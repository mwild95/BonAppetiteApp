//
//  OpeningTime.swift
//  Ordering
//
//  Created by Michael Wild on 01/12/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON

class OpeningTime {
    var days : [String] = []
    var openTime : Date!
    var closeTime: Date!
    
    init ( openingTimeJSON: JSON ) {
        self.setDays(_days: openingTimeJSON["days"].array!)
        self.setOpenTime(_openTime: openingTimeJSON["open"].string!)
        self.setCloseTime(_closeTime: openingTimeJSON["close"].string!)
        
    }
    
    func getDays () -> [String] {
        return self.days
    }
    
    func setDays( _days : [JSON] ) -> Void {
        for day in _days {
            self.days.append(day.rawString()!)
        }
    }
    
    func getOpenTime ( ) -> Date {
        return self.openTime
    }
    
    func setOpenTime( _openTime: String ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: _openTime)
        self.openTime = date
    }
    
    func getCloseTime( ) -> Date {
        return self.closeTime
    }
    
    func setCloseTime( _closeTime: String ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: _closeTime)
        self.closeTime = date
    }
}
