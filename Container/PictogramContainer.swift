//
//  PictogramContainer.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

public protocol PictogramContainerType: ModelContainerType {
    /// Saves an array of persistable models in the container
    func save(pictograms: [Pictogram]) -> Observable<Void>
    
    /// Deletes the persistable model with a given identifier
    func delete(pictogramWithIdentifier: Int ) -> Observable<Void>
    
    /// Determines if the container contains a persistable model with a given identifier
    func contains(pictogramWithIdentifier: Int) -> Bool
    
    /// Returns all the persistable models in the container
    func allPictograms() -> PictogramResultsType
}

extension ModelContainer: PictogramContainerType {
    

    /// Returns all the pictogram in the container
    public func allPictograms() -> PictogramResultsType {
        return PictogramResults(fetchRequest: PictogramEntry.defaultFetchRequest(), context: container.viewContext)
    }
    
    /// Determines if the container contains a pictogram with a given identifier
    public func contains(pictogramWithIdentifier identifier: Int) -> Bool {
        let fetchRequest = PictogramEntry.fetchRequest(forModelWithIdentifier: identifier)
        
        let count = (try? container.viewContext.count(for: fetchRequest)) ?? 0
        
        return count > 0
    }
    
    /// Saves an array of pictograms in the container
    public func save(pictograms: [Pictogram]) -> Observable<Void> {
        return performBackgroundTask { context in
            
            let _ = pictograms.map { $0.managedObject(context: context) }
            try context.save()
        }

    }
    
    /// Deletes the pictogram with a given identifier
    public func delete(pictogramWithIdentifier identifier: Int) -> Observable<Void> {
        return performBackgroundTask { context in
            let fetchRequest = PictogramEntry.fetchRequest(forModelWithIdentifier: identifier)
            let entries = try context.fetch(fetchRequest)
            
            if entries.count > 0 {
                context.delete(entries[0])
                try context.save()
            }
        }
    }
    
}
