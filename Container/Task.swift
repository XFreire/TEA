//
//  Task.swift
//  TEA
//
//  Created by Alexandre Freire García on 2/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public struct Task {
    
    // MARK: - Properties
    public let identifier: String
    public let name: String
    public var daysOfWeek = [Int]()
    
    // MARK: - Relationships
    public var pictograms = [Pictogram]()
}

extension Task: Persistable {
    public init(managedObject: TaskEntry) {
        identifier = managedObject.identifier
        name = managedObject.name
        daysOfWeek = managedObject.daysOfWeek as [Int]
        pictograms = managedObject.pictograms.flatMap{ Pictogram(managedObject: $0 as! PictogramEntry) }
    }
    
    public func managedObject(context: NSManagedObjectContext) -> TaskEntry {
        let taskEntry = TaskEntry(context: context)
        taskEntry.identifier = identifier
        taskEntry.name = name
        taskEntry.pictograms = NSSet(array: pictograms.flatMap{ $0.managedObject })
        
        return taskEntry
    }
}
