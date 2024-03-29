//
//  MainTableViewController.swift
//  TDV5
//
//  Created by Stuart Robinson on 09/03/2015.
//  Copyright (c) 2015 SJR Development. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
   
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var lists = [Lists]()
    
    var listsCount:Int = 1
   
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
        
        println("saved state")
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Im loaded")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
       
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
       
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        // Create a new fetch request using the LogItem entity
        let fetchRequest = NSFetchRequest(entityName: "Lists")
        
        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Lists] {
            
            lists = fetchResults
            
            listsCount = fetchResults.count
            
            println(listsCount)
            
            self.tableView.reloadData()
        } else {
            println("no data")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return lists.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("myCell")
            as UITableViewCell
        
        cell.textLabel!.text = lists[indexPath.row].valueForKey("listName") as String?
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
            
        
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier! == "showListItemsView") {
  
            // Get the new view controller using [segue destinationViewController].
            var listView = segue.destinationViewController as ListViewController
            // Pass the selected object to the new view controller.
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let selectedList = lists[indexPath.row]
                listView.currentList = selectedList.listName
                
        
            }
        }
    }
    



}
