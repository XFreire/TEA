//
//  ModelContainer.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

/// A collection of volumes persisted in disk
public protocol ModelContainerType {
    
    /// Loads the correspongind store for the container
    func load() -> Observable<Void>
    
    /// Saves an array of persistable models in the container
    func save<T: Persistable>(models: [T]) -> Observable<Void>
    
    /// Deletes the persistable model with a given identifier
    func delete(modelWithIdentifier: Int ) -> Observable<Void>
    
    /// Determines if the container contains a persistable model with a given identifier
    func contains(modelWithIdentifier: Int) -> Bool
    
    /// Returns all the persistable models in the container
    func all<T: ModelResultsType>() -> T
}

public class ModelContainer {
    
    // MARK: - Properties
    internal let container: NSPersistentContainer
    
    // MARK: - Initialization
    private init(container: NSPersistentContainer) {
        self.container = container
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public convenience init(name: String){
        let bundle = Bundle(for: ModelContainer.self)
        let model = NSManagedObjectModel.mergedModel(from: [bundle])!
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        self.init(container: container)
    }
    
    public static func temporary() -> ModelContainer {
        let bundle = Bundle(for: ModelContainer.self)
        let model = NSManagedObjectModel.mergedModel(from: [bundle])!
        
        let container = TemporaryPersistentContainer(managedObjectModel: model)
        
        return ModelContainer(container: container)
    }
    
    func performBackgroundTask(_ task: @escaping (NSManagedObjectContext) throws ->Void) -> Observable<Void> {
        
        return Observable.create { observer in
            
            self.container.performBackgroundTask { context in
                do {
                    try task(context) 
                    observer.onNext()
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}



