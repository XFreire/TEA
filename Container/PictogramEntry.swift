//
//  PictogramEntry.swift
//  TEA
//
//  Created by Alexandre Freire García on 1/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import CoreData

public final class PictogramEntry: NSManagedObject {
    
    // MARK: - Properties
    @NSManaged public var identifier: String
    @NSManaged public var name: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var audioUrl: String?
    @NSManaged public var wordType: NSNumber?
    // MARK: - Relationships
    @NSManaged public var audio: AudioEntry?
    @NSManaged public var image: ImageEntry?
    @NSManaged public var task: TaskEntry?

}

extension PictogramEntry: Fetchable {
    
    public static func defaultFetchRequest() -> NSFetchRequest<PictogramEntry> {
        let fetchRequest = NSFetchRequest<PictogramEntry>(entityName: "PictogramEntry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: true)]
        
        return fetchRequest
    }
    
    public static func fetchRequest(forModelWithIdentifier identifier: Int) -> NSFetchRequest<PictogramEntry>{
        let fetchRequest = NSFetchRequest<PictogramEntry>(entityName: "PictogramEntry")
        fetchRequest.predicate = NSPredicate(format: "identifier == %d", identifier)
        fetchRequest.fetchLimit = 1
        
        return fetchRequest
    }
}
