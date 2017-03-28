//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Sean Melnick Kelly on 3/28/17.
//  Copyright © 2017 Sean Melnick Kelly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,  UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField! // pg. 234 for 4 outlets
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    // Action when nothing is tapped to kill keyboard - pg. 250
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    var item: Item! {
        // Added property observer to the item property that updates title of navigationItem - pg. 253
        didSet {
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NumberFormatter = { // pg.236
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = { // pg. 236
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text =
            numberFormatter.string(from: NSNumber(value: item.valueInDollars)) // pg. 236
        dateLabel.text = dateFormatter.string(from: item.dateCreated) // pg. 236
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responser - pg. 251
        view.endEditing(true) // smoothly removes keyboard when the back button is hit
        
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) { // pg. 246
            item.valueInDollars = value.intValue
        }
        else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // pg. 249
        // Delegate that is called whenever the return button is pressed
        textField.resignFirstResponder()
        return true
    }
}
