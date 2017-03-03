//
//  ImageEntry.swift
//  TEA
//
//  Created by Alexandre Freire García on 1/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public final class ImageEntry: NSManagedObject {
    
    // MARK: - Properties
    @NSManaged public var identifier: String
    @NSManaged public var imageData: NSData?
    @NSManaged public var imageUrl: String?
    
    // MARK: - Relationships
    @NSManaged public var pictogram: PictogramEntry?
}
