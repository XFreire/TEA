//
//  Audio.swift
//  TEA
//
//  Created by Alexandre Freire García on 2/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public struct Audio {
    
    // MARK: - Properties
    public let identifier: String
    public var audioData: NSData?
    public var audioUrl: URL?
    
    // MARK: - Relationships
    //public var pictogram: Pictogram
    
}

extension Audio: Persistable {
    public init(managedObject: AudioEntry) {
        identifier = managedObject.identifier
        audioData = managedObject.audioData
        audioUrl =  managedObject.audioUrl.flatMap { URL(string: $0) }
        //pictogram =  Pictogram(managedObject: managedObject.pictogram )

        
    }
    
    public func managedObject(context: NSManagedObjectContext) -> AudioEntry {
        let audioEntry = AudioEntry(context: context)
        audioEntry.identifier = identifier
        audioEntry.audioData = audioData
        audioEntry.audioUrl = audioUrl?.absoluteString
        //audioEntry.pictogram = pictogram.managedObject(context: context)
        
        
        return audioEntry
    }
    
}
