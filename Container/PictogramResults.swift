//
//  PictogramResults.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public protocol PictogramResultsType: class {
    
    /// Called when models are inserted, updated, or removed
    var didUpdate: () -> Void {get set }
    
    /// The number of models in tge result set
    var numberOfPictograms: Int {get}
    
    /// Returns the volume at a given index
    func pictogram(at index: Int) -> Pictogram
    
    func all() -> [Pictogram]
    
}


final public class PictogramResults: NSObject, PictogramResultsType {
    
    // MARK: - ModelResultsType
    public var didUpdate: () -> Void = {}
    
    public var numberOfPictograms: Int {
        return resultsController.fetchedObjects?.count ?? 0
        
    }

    public func pictogram(at index: Int) -> Pictogram {
        let indexPath = IndexPath(indexes: [0, index])
        let entry = resultsController.object(at: indexPath)
        return Pictogram(managedObject: entry)
    }
    
    public func all() -> [Pictogram] {
        let maybeEntries = resultsController.fetchedObjects
        guard let entries = maybeEntries else { return [] }
        
        return entries.map{ Pictogram(managedObject: $0) }
    }
    
    // MARK: - Properties
    private let resultsController : NSFetchedResultsController<PictogramEntry>
    
    // MARK: - Initialization
    init(fetchRequest: NSFetchRequest<PictogramEntry>, context: NSManagedObjectContext) {
        
        resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        resultsController.delegate = self
        try! resultsController.performFetch()
        
    }
}

extension PictogramResults: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didUpdate()
    }
}
