//
//  TaskResults.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData
public protocol TaskResultsType: class {
    
    /// Called when tasks are inserted, updated, or removed
    var didUpdate: () -> Void {get set }
    
    /// The number of tasks in tge result set
    var numberOfTasks: Int {get}
    
    /// Returns the task at a given index
    func task(at index: Int) -> Task
    
    func all() -> [Task]
    
}

public final class TaskResults: NSObject, TaskResultsType {

    // MARK: - ModelResultsType
    public var didUpdate: () -> Void = {}
    
    public var numberOfTasks: Int {
        return resultsController.fetchedObjects?.count ?? 0
        
    }
    
    public func task(at index: Int) -> Task {
        let indexPath = IndexPath(indexes: [0, index])
        let entry = resultsController.object(at: indexPath)
        return Task(managedObject: entry)
    }
    
    public func all() -> [Task] {
        let entries = resultsController.fetchedObjects
        let maybeTasks = entries?.flatMap{ Task(managedObject: $0) }
        guard let tasks = maybeTasks else { return [] }
        return tasks
    }
    
    // MARK: - Properties
    private let resultsController : NSFetchedResultsController<TaskEntry>
    
    // MARK: - Initialization
    init(fetchRequest: NSFetchRequest<TaskEntry>, context: NSManagedObjectContext) {
        
        resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        resultsController.delegate = self
        try! resultsController.performFetch()
        
    }
}

extension TaskResults: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didUpdate()
    }
}
