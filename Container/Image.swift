//
//  Image.swift
//  TEA
//
//  Created by Alexandre Freire García on 2/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public struct Image {
    
    // MARK: - Properties
    public var identifier: String
    public var imageData: NSData?
    public var imageUrl: URL?
    
    // MARK: - Relationships
    //public var pictogram: Pictogram?
}

extension Image: Persistable {
    public init(managedObject: ImageEntry) {
        identifier = managedObject.identifier
        imageData = managedObject.imageData
        imageUrl = managedObject.imageUrl.flatMap{ URL(string: $0) }
        //pictogram = Pictogram(managedObject: managedObject.pictogram)
    }
    
    public func managedObject(context: NSManagedObjectContext) -> ImageEntry {
        let imageEntry = ImageEntry(context: context)
        imageEntry.identifier = identifier
        imageEntry.imageData = imageData
        imageEntry.imageUrl = imageUrl?.absoluteString
        //imageEntry.pictogram = pictogram.managedObject(context: context)
        
        return imageEntry
    }
    
}
