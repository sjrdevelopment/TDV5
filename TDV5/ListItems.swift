//
//  ListItems.swift
//  TDV5
//
//  Created by Stuart Robinson on 28/03/2015.
//  Copyright (c) 2015 SJR Development. All rights reserved.
//

import Foundation
import CoreData

@objc(ListItems)
class ListItems: NSManagedObject {

    @NSManaged var listName: String
    @NSManaged var itemName: String

}
