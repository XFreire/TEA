//
//  TaskResults.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

internal final class TaskResults: NSObject, ModelResultsType {

    typealias Model = Task

    // MARK: - ModelResultsType
    var didUpdate: () -> Void = {}
    
    var numberOfModels: Int {
        return resultsController.fetchedObjects?.count ?? 0
        
    }
    
    var numberOfTask: Int {
        return numberOfModels
    }
    
    func model(at index: Int) -> Model {
        let indexPath = IndexPath(indexes: [0, index])
        let entry = resultsController.object(at: indexPath)
        return Model(managedObject: entry)
    }
    
    func task(at index: Int) -> Model {
        return model(at: index)
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
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didUpdate()
    }
}
