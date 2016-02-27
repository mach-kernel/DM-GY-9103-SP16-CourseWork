//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by David Stancu on 2/23/16.
//  Copyright © 2016 David Stancu. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left:0, bottom:0, right:0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            sender.setTitle("Edit", forState: .Normal)
            
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", forState: .Normal)
            
            setEditing(true, animated: true)
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            let ac = UIAlertController(title: "Delete \(item.name)", message: "Are you sure you want to delete this item?", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            
            ac.addAction(deleteAction)
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.Value1, reuseIdentifier: "UITableViewCell")
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        return cell
    }
}
