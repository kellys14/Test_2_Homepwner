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
    
    func removeItem(_ item: Item) {  // pg. 202
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert
        let movedItem = allItems[fromIndex]
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
