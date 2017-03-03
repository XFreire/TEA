//
//  ModelResultsType.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public protocol ModelResultsType {
    
    associatedtype Model: Persistable

    
    /// Called when models are inserted, updated, or removed
    var didUpdate: () -> Void {get set }
    
    /// The number of models in tge result set
    var numberOfModels: Int {get}
    
    /// Returns the volume at a given index
    func model(at index: Int) -> Model
    
}

