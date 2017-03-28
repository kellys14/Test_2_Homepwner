//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Sean Melnick Kelly on 3/13/17.
//  Copyright © 2017 Sean Melnick Kelly. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton) { // pg. 201
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where the item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) { // pg. 199
        // If you are currently in editing mode...
        if isEditing {
            //Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        }
        else {
            // Chnage text button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() { //
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension // pg. 216
        tableView.estimatedRowHeight = 65 // pg. 216
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int { // pg. 186
        
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a new or recyclced cell - pg. 192
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        
        // Set the text on the cell with description of the item
        // that is at the Nth index of items, where n = row of this cell
        // will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
        // Configure the cell with the Item  // pg. 215 w/ 3 lines below
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                                 handler: { (action) -> Void in
            
            // Remove the item from the store
            self.itemStore.removeItem(item)
            
            // Also remove that row from the table view with an animation
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // pg. 237
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
            case "showItem"?:
                // Figure out which row was just tapped
                if let row = tableView.indexPathForSelectedRow?.row {
                    
                    // Get the item associated with this row and pass it along
                    let item = itemStore.allItems[row]
                    let detailViewController
                            = segue.destination as! DetailViewController
                    detailViewController.item = item
                }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) { // pg. 246
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}


