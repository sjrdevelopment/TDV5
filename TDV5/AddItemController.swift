//
//  AddItemController.swift
//  TDV5
//
//  Created by Stuart Robinson on 09/03/2015.
//  Copyright (c) 2015 SJR Development. All rights reserved.
//

import UIKit
import CoreData

class AddItemController: UIViewController {
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func saveButton(sender: AnyObject) {
        if(!inputField.text.isEmpty) {
            
            let newItem = NSEntityDescription.insertNewObjectForEntityForName("Lists", inManagedObjectContext: self.managedObjectContext!) as Lists
        
            newItem.listName = inputField.text
        
            save()
        }
    }
    
    // make data persist
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   /*
// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var addItemScene = segue.destinationViewController as AddItemController
        addItemScene.dataObject = currentPhoto!.notes
    }
*/


}
