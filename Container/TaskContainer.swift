//
//  TaskContainer.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

public protocol TaskContainerType: ModelContainerType {
    /// Saves an array of persistable models in the container
    func save(tasks: [Task]) -> Observable<Void>
    
    /// Deletes the persistable model with a given identifier
    func delete(taskWithIdentifier: Int ) -> Observable<Void>
    
    /// Determines if the container contains a persistable model with a given identifier
    func contains(taskWithIdentifier: Int) -> Bool
    
    /// Returns all the persistable models in the container
    func allTasks() -> TaskResultsType
    
    /// Returns all the persistable models in the container with a given day of week
    func allTasks(forDay: DaysOfWeek) -> TaskResultsType
    
    
}

extension ModelContainer: TaskContainerType {
    
    
    /// Returns all the task in the container
    public func allTasks() -> TaskResultsType {
        return TaskResults(fetchRequest: TaskEntry.defaultFetchRequest(), context: container.viewContext)
    }
    
    /// Returns all the persistable models in the container with a given day of week
    public func allTasks(forDay day: DaysOfWeek) -> TaskResultsType {
        return TaskResults(fetchRequest: TaskEntry.fetchRequest(forTasksForDay: day), context: container.viewContext)
    }
    
    /// Determines if the container contains a task with a given identifier
    public func contains(taskWithIdentifier identifier: Int) -> Bool {
        let fetchRequest = TaskEntry.fetchRequest(forModelWithIdentifier: identifier)
        
        let count = (try? container.viewContext.count(for: fetchRequest)) ?? 0
        
        return count > 0
    }
    
    /// Saves an array of tasks in the container
    public func save(tasks: [Task]) -> Observable<Void> {
        return performBackgroundTask { context in
            
            _ = tasks.map{ $0.managedObject(context: context) }
            try context.save()
        }
        
    }
    
    /// Deletes the task with a given identifier
    public func delete(taskWithIdentifier identifier: Int) -> Observable<Void> {
        return performBackgroundTask { context in
            let fetchRequest = TaskEntry.fetchRequest(forModelWithIdentifier: identifier)
            let entries = try context.fetch(fetchRequest)
            
            if entries.count > 0 {
                context.delete(entries[0])
                try context.save()
            }
        }
    }
}
