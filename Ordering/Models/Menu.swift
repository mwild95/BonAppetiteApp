//
//  Menu.swift
//  Ordering
//
//  Created by Michael Wild on 14/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import SwiftyJSON

class Menu : OwnedBy{
    
    var exists: Bool
    var sections : [Section] = []
    
    override init () {
        self.exists = true;
        super.init()
    }
    
    init(menuJSON: JSON)
    {
        self.exists = true
        super.init()

        if( menuJSON.isEmpty ){
            exists = false
        } else {
            exists = true
            self.setId(menuJSON["_id"].string!)
            self.setName(menuJSON["name"].string!)
            self.setOwningUser((menuJSON["owning_user"].string) ?? "")
            self.setSections(_sections: menuJSON["sections"].array!)
        }
    }
    
    override func getName ( ) -> String{
        if( exists ) {
            return self.name
        }else {
            return "";
        }
    }
    
    override func getId() -> String {
        if( exists ) {
            return self._id
        } else {
            return ""
        }
    }
    
    func setSections ( _sections : [JSON] ) {
        //loop through and create a section
        for section in _sections {
            if(section.type == .dictionary ) {
                let tempObj = Section(sectionJSON: section)
                self.sections.append(tempObj)
            }
            
        }
    }
    
    func getSections ( ) -> [Section] {
        return self.sections
    }
    
    //put in sections
    
}
