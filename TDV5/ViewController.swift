//
//  ViewController.swift
//  TDV5
//
//  Created by Stuart Robinson on 08/03/2015.
//  Copyright (c) 2015 SJR Development. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var lists = [Lists]()
    
    var listsCount:Int = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var listsTableView: UITableView!
    
    // TableView stuff
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listsCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
        tableView.dequeueReusableCellWithIdentifier("myCell")
            as UITableViewCell
        
        cell.textLabel!.text = lists[indexPath.row].valueForKey("listName") as String?
        
        return cell
    }
    
    // other stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //listsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Create a new fetch request using the LogItem entity
        let fetchRequest = NSFetchRequest(entityName: "Lists")
        
        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Lists] {
            
            lists = fetchResults
            
            listsCount = fetchResults.count
            
            countLabel.text = String(listsCount)
            
            self.listsTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "reusableCell" {
            println("cell clicked")
        }
    }
    
}

