//
//  Resource.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation

public enum Method: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public protocol Resource {
    var method: Method { get }
    var path : String { get }
    var parameters: [String : String] { get }
}

extension Resource {
    public var method: Method {
        return .GET
    }
    
    public var parameters: [String : String ] {
        return [:]
    }
    
    func request(withBaseUrl baseURL: URL,
                 additionalParameters: [String: String]) -> URLRequest{
        
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        var parameters = self.parameters
        additionalParameters.forEach {
            parameters.updateValue($1, forKey: $0) // $1 value $0 key
        }
        
        components.queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
        
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        return request
    }
    
}

