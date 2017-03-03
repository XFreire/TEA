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

final class PictogramContainer: ModelContainer, ModelContainerType {
    
    func allPictograms() -> PictogramResults {
        return all()
    }
    
    func contains(pictogramWithIdentifier id: Int) -> Bool{
        return contains(modelWithIdentifier: id)
    }
    
    func save(pictograms: [Pictogram]) -> Observable<Void> {
        return save(models: pictograms)
    }
    
    func delete(pictogramWithIdentifier id: Int) -> Observable<Void> {
        return delete(modelWithIdentifier: id)
    }
    
    /// Returns all the pictogram in the container
    func all<T : ModelResultsType>() -> T {
        return PictogramResults(fetchRequest: PictogramEntry.defaultFetchRequest(), context: container.viewContext) as! T
    }
    
    /// Determines if the container contains a pictogram with a given identifier
    public func contains(modelWithIdentifier identifier: Int) -> Bool {
        let fetchRequest = PictogramEntry.fetchRequest(forModelWithIdentifier: identifier)
        
        let count = (try? container.viewContext.count(for: fetchRequest)) ?? 0
        
        return count > 0
    }
    
    /// Saves an array of pictograms in the container
    func save<T : Persistable>(models: [T]) -> Observable<Void> {
        return performBackgroundTask { context in
            
            let _ = models.map { $0.managedObject(context: context as! T.Context) }
            try context.save()
        }

    }
    
    /// Deletes the pictogram with a given identifier
    public func delete(modelWithIdentifier identifier: Int) -> Observable<Void> {
        return performBackgroundTask { context in
            let fetchRequest = PictogramEntry.fetchRequest(forModelWithIdentifier: identifier)
            let entries = try context.fetch(fetchRequest)
            
            if entries.count > 0 {
                context.delete(entries[0])
                try context.save()
            }
        }
    }
    
    /// Loads the correspongind store for the container
    public func load() -> Observable<Void> {
        return Observable.create { observer in
            self.container.loadPersistentStores(completionHandler: { _, error in
                if let error = error {
                    observer.onError(error)
                }
                else{
                    observer.onNext()
                    observer.onCompleted()
                }
            })
            
            return Disposables.create()
            
        }
    }
}
