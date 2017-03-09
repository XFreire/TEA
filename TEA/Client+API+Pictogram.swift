//
//  Client+API+Pictogram.swift
//  TEA
//
//  Created by Alexandre Freire García on 7/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import RxSwift
import Container
import TEAService

extension Pictogram: JSONDecodable {
    public init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            let imageUrlString = dictionary["imagePNGURL"] as? String else {
                return nil
        }
        self.identifier = UUID().uuidString
        self.name = name.uppercased()
        self.imageUrl =  URL(string: imageUrlString)
        self.audioUrl = (dictionary["soundMP3URL"] as? String).flatMap{ URL(string: $0) }
        self.wordType = nil
        self.audio = nil
        self.image = nil
        self.task = nil
    }
}

extension Client {
    
    public func searchPictograms(forQuery query: String) -> Observable<[Pictogram]>{
        return objects(forResource: API.pictograms(query: query))
    }
    public func searchPictogram(forQuery query: String) -> Observable<Pictogram>{
        return object(forResource: API.pictograms(query: query))
    }
}
