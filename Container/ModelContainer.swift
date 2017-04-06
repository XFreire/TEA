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
}

extension ModelContainer{
    internal func performBackgroundTask(_ task: @escaping (NSManagedObjectContext) throws ->Void) -> Observable<Void> {
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

extension ModelContainer: ModelContainerType {
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



