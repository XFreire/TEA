//
//  API.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation

public enum API {
    case pictograms(query: String)
}

extension API: Resource {
    
    public var path: String {
        switch self {
        case .pictograms:
            return "index.php"
        }
    }
    
    public var parameters: [String : String] {
        switch self {
        case .pictograms(query: let q):
            return [
                "callback"          :   "json",
                "language"          :   "ES",
                "catalog"           :   "colorpictos",
                "ThumbnailSize"     :   "150",
                "TXTlocate"         :   "4",
                "nresults"          :   "1",
                "word"              :   q
            ]
        }
    }
}
