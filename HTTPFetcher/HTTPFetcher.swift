//
//  HTTPFetcher.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import RxSwift

public enum HTTPError: Error {
    case badStatus(Int)
}

/// An object that fetches the data for a HTTP request
public protocol HTTPFetcher {
    
    /// Fetches the contents of a URL based on the specified request object.
    ///
    /// - parameter request: An `NSURLRequest` object that provides the URL, request type, etc.
    ///
    /// - returns: An observable that will send the contents and complete.
    
    func data(request: URLRequest) -> Observable<Data>
}
