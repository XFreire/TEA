//
//  Response.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation

public struct Response {
    
    // MARK: - Properties
    public      let itemCount      :   Int
    public      let page     :   Int
    public      let totalItemCount     :   Int
    public      let pageCount     :   Int
    fileprivate let payload     :   Any
    
    
    public func result<T: JSONDecodable>() -> T? {
        let array: [T]? =  (payload as? [JSONDictionary]).flatMap(decode)
        return array?.first
        
    }
    
    public func results<T: JSONDecodable>() -> [T]? {
        return (payload as? [JSONDictionary]).flatMap(decode)
    }
}

extension Response: JSONDecodable{
    public init?(dictionary: JSONDictionary) {
        guard
            let itemCount = dictionary["itemCount"] as? Int,
            let page = dictionary["page"] as? Int,
            let totalItemCount = dictionary["totalItemCount"] as? Int,
            let pageCount = dictionary["pageCount"] as? Int,
            let payload = dictionary["symbols"] else {
                
                return nil
        }
        
        self.itemCount = itemCount
        self.page = page
        self.totalItemCount = totalItemCount
        self.pageCount = pageCount
        self.payload = payload
    }
}
