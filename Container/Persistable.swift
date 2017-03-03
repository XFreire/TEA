//
//  Persistable.swift
//  TEA
//
//  Created by Alexandre Freire García on 2/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public protocol Persistable {
    
    associatedtype ManagedObject: NSManagedObject
    associatedtype Context: NSManagedObjectContext
    
    init(managedObject: ManagedObject)
    func managedObject(context: Context) -> ManagedObject
    
}
