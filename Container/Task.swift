//
//  Task.swift
//  TEA
//
//  Created by Alexandre Freire García on 2/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public enum DaysOfWeek: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
}

public struct Task {
    
    // MARK: - Properties
    public let identifier: String
    public let name: String
    public var daysOfWeek = [Int]()
    public var imageIndex: Int = -1
    public var coverUrl: URL? {
        return pictograms[imageIndex].imageUrl
    }
    
    // MARK: - Relationships
    public var pictograms = [Pictogram]()
    
    public init(identifier: String = UUID().uuidString, name: String, daysOfWeek: [Int], pictograms: [Pictogram], imageIndex: Int = 0) {
        self.identifier = identifier
        self.name = name
        self.daysOfWeek = daysOfWeek
        self.pictograms = pictograms
        self.imageIndex = imageIndex
    }
    
}

extension Task: Persistable {
    public init(managedObject: TaskEntry) {
        identifier = managedObject.identifier
        name = managedObject.name
        daysOfWeek = managedObject.daysOfWeek.components(separatedBy: ",").flatMap{ Int($0) }
        imageIndex = Int(managedObject.imageIndex)
        pictograms  = managedObject.sortedPictograms.flatMap{ Pictogram(managedObject: $0) }
    }
    
    public func managedObject(context: NSManagedObjectContext) -> TaskEntry {
        let taskEntry = TaskEntry(context: context)
        taskEntry.identifier = identifier
        taskEntry.name = name
        taskEntry.daysOfWeek = daysOfWeek.reduce("", { "\($0),\($1)" })
        taskEntry.imageIndex = NSNumber(integerLiteral: imageIndex)
        taskEntry.pictograms = NSSet(array: pictograms.flatMap{ $0.managedObject(context: context) })
        return taskEntry
    }
}
