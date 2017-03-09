//
//  Pictogram.swift
//  TEA
//
//  Created by Alexandre Freire García on 2/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public struct Pictogram {
    
    // MARK: - Properties
    public let identifier: String
    public let name: String
    public var audioUrl: URL?
    public var imageUrl: URL?
    public var wordType: Int?
    
    // MARK: - Relationships
    public var audio: Audio?
    public var image: Image?
    public var task: Task?
    
    // MARK: - Initialization
    public init(identifier: String, name: String, audioUrl: URL? = nil, imageUrl: URL? = nil, wordType: Int? = nil, audio: Audio? = nil, image: Image? = nil, task: Task? = nil){
        
        self.identifier = identifier
        self.name = name
        self.audioUrl = audioUrl
        self.imageUrl = imageUrl
        self.wordType = wordType
        self.audio = audio
        self.image = image
        self.task = task
    }
}

extension Pictogram: Persistable {
    
    public init(managedObject: PictogramEntry) {
        identifier = managedObject.identifier
        name = managedObject.name
        audioUrl = managedObject.audioUrl.flatMap{ URL(string: $0) }
        imageUrl = managedObject.imageUrl.flatMap{ URL(string: $0) }
        audio = managedObject.audio.flatMap(Audio.init(managedObject:))
        image = managedObject.image.flatMap(Image.init(managedObject:))
        task = managedObject.task.flatMap(Task.init(managedObject:))
    }
    
    public func managedObject(context: NSManagedObjectContext) -> PictogramEntry {
        let pictogramEntry = PictogramEntry(context: context)
        
        pictogramEntry.identifier = identifier
        pictogramEntry.name = name
        pictogramEntry.audioUrl = audioUrl?.absoluteString
        pictogramEntry.imageUrl = imageUrl?.absoluteString
        pictogramEntry.audio = audio?.managedObject(context: context)
        pictogramEntry.image = image?.managedObject(context: context)
        pictogramEntry.task = task?.managedObject(context: context)
        
        return pictogramEntry
    }
}
