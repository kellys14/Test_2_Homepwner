//
//  ItemStore.swift
//  Homepwner
//
//  Created by Sean Melnick Kelly on 3/13/17.
//  Copyright © 2017 Sean Melnick Kelly. All rights reserved.
//

import UIKit

class ItemStore {  // When called will create objects to be added to Item
    
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item { // pg. 184
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init() {  // pg. 185
        for _ in 0..<5 {
            createItem()
        }
    }
}
