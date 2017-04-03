//
//  Item.swift
//  Homepwner
//
//  Created by Sean Melnick Kelly on 3/13/17.
//  Copyright © 2017 Sean Melnick Kelly. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    let itemKey: String
    
    // MARK: Initializers
    init(name: String, serialNumber: String?, valueInDollars: Int) { // designated initializer - pg. 181
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
    }
    
    convenience init(random: Bool = false) {  // convience initializer - pg. 182
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
        else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    // MARK: Archiving methods
    func encode(with aCoder: NSCoder) { // pg. 284
        // Function to encode all of Item's properities into the NSCoder object
        // that is passed as an arguement. While saving, NSCoder is used to write
        // out a stream of data, that will be organized as key-value pairs
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    required init(coder aDecoder: NSCoder) { // pg. 286
        // This method grabs all objects that were encoded in encode(with:) and
        // assigns them to the appropriate property
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        
        super.init() 
    }
}


