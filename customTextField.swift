//
//  customTextField.swift
//  Homepwner
//
//  Created by Sean Melnick Kelly on 3/28/17.
//  Copyright © 2017 Sean Melnick Kelly. All rights reserved.
//

import UIKit

class customTextField: UITextField { // class to change UITextField borderStyle
    
    override func becomeFirstResponder() -> Bool { // pg. 257 - Ch. 14 Silver
        // Line below allows object to leave firstResponder
        let becomeFirstResponder = super.becomeFirstResponder()
        print("First Responder Become for \(self.text)")

        self.borderStyle = .line
        self.backgroundColor = UIColor.yellow

        return true
    }
    
    override func resignFirstResponder() -> Bool { // pg. 257 - Ch. 14 Silver
        print("First Responder Resigned for \(self.text)")
        
        self.borderStyle = .roundedRect
        self.backgroundColor = UIColor.clear
        
        return super.resignFirstResponder()
    }
}
