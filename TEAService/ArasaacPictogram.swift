//
//  ArasaacPictogram.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation

public struct ArasaacPictogram {
    public let name: String
    public let imageUrl: URL?
    public let audioUrl: URL?
    
    public init(name: String, imageUrl: URL, audioUrl: URL? = nil) {
        self.name = name
        self.imageUrl = imageUrl
        self.audioUrl = audioUrl
    }
}

extension ArasaacPictogram: JSONDecodable {
    public init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            let imageUrlString = dictionary["imagePNGURL"] as? String else {
                return nil
        }
        
        self.name = name
        self.imageUrl =  URL(string: imageUrlString)
        self.audioUrl = (dictionary["soundMP3URL"] as? String).flatMap{ URL(string: $0) }
    }
}
