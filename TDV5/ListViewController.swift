//
//  ListViewController.swift
//  TDV5
//
//  Created by Stuart Robinson on 09/03/2015.
//  Copyright (c) 2015 SJR Development. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDataSource {
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var listItems = [ListItems]()
    
    var listItemsCount:Int = 0
    
    var currentList:String = ""
    
    @IBOutlet weak var listItemsTableView: UITableView!
    
    @IBOutlet weak var listNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listNameLabel.text = currentList

        loadDataForList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataForList() {
        
        // Create a new fetch request using the LogItem entity
        let fetchRequest = NSFetchRequest(entityName: "ListItems")
        
        //predicate filter
        fetchRequest.predicate = NSPredicate(format: "listName = %@", currentList)
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ListItems] {
            
            listItems = fetchResults
            
            listItemsCount = fetchResults.count
            
            println("You have \(fetchResults.count) in this list")

            listItemsTableView.reloadData();
        } else {
            println("no data")
        }

    }
    
    // make data persist
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
        
        println("saved state")
        loadDataForList()
    }
    
    @IBAction func addNewListItem(sender: AnyObject) {
            
        let addItemAlertViewTag = 0
        let addItemTextAlertViewTag = 1
        
        var stringPlaceholder = "this is placeholder"
        
        var titlePrompt = UIAlertController(title: "Enter List Title",
            message: nil,
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "Title"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    if(countElements(textField.text) > 0) {
                        
                        println(textField.text)
                        let newListItem = NSEntityDescription.insertNewObjectForEntityForName("ListItems", inManagedObjectContext: self.managedObjectContext!) as ListItems
                        
                        newListItem.listName = self.currentList
                        newListItem.itemName = textField.text
                        
                        self.save()

                        
                    } else {
                        // cancel item
                    }
                    
                }
        }))
        
        titlePrompt.addAction(UIAlertAction(title: "Cancel",
            style: .Cancel,
            handler: { (action) -> Void in
                // cancel item
        }))
        
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
            
  

    }
    
    
    
    
    // Table stuff

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listItemsCount
       
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("listItemCell", forIndexPath: indexPath) as UITableViewCell
        
        
        cell.textLabel?.text = listItems[indexPath.row].itemName
    
        
        return cell
    }

    
    // END: table stuff
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
