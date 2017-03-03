//
//  TemporaryPersistentContainer.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

internal final class TemporaryPersistentContainer: NSPersistentContainer {
    override class func defaultDirectoryURL() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    init(managedObjectModel model: NSManagedObjectModel) {
        super.init(name: UUID().uuidString, managedObjectModel: model)
    }
}
