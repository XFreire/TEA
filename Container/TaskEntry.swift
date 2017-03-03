//
//  TaskEntry.swift
//  TEA
//
//  Created by Alexandre Freire García on 1/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public final class TaskEntry: NSManagedObject {
    
    // MARK: - Properties
    @NSManaged public var identifier: String
    @NSManaged public var name: String
    @NSManaged var daysOfWeek: [NSNumber]
    
    // MARK: - Relationships
    @NSManaged public var pictograms: NSSet

}

extension TaskEntry: Fetchable {
    
    public static func defaultFetchRequest() -> NSFetchRequest<TaskEntry> {
        let fetchRequest = NSFetchRequest<TaskEntry>(entityName: "TaskEntry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: true)]
        
        return fetchRequest
    }
    
    public static func fetchRequest(forModelWithIdentifier identifier: Int) -> NSFetchRequest<TaskEntry>{
        let fetchRequest = NSFetchRequest<TaskEntry>(entityName: "TaskEntry")
        fetchRequest.predicate = NSPredicate(format: "identifier == %d", identifier)
        fetchRequest.fetchLimit = 1
        
        return fetchRequest
    }
}
