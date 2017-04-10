//
//  DateChange.swift
//  Homepwner
//
//  Created by Sean Melnick Kelly on 4/10/17.
//  Copyright © 2017 Sean Melnick Kelly. All rights reserved.
//

import UIKit

class DateChange: UIViewController {
    
    var item: Item
    
    init(item: Item) {
        self.item = item
        
        super.init(nibName: "DatePickerViewController", bundle: nil)
        
        navigationItem.title = item.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var dateChanger: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dateChanger.date = item.dateCreated
    }
}
