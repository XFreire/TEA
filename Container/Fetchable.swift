//
//  Fetchable.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public protocol Fetchable {
    
    associatedtype ManagedObject: NSManagedObject
    
    static func defaultFetchRequest() -> NSFetchRequest<ManagedObject>
    static func fetchRequest(forModelWithIdentifier identifier: Int) -> NSFetchRequest<ManagedObject>
    
}
