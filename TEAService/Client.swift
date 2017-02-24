//
//  Client.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation

import HTTPFetcher
import RxSwift

private let baseURL = URL(string: "http://arasaac.org/api")!
private let key = "XCjJE7agCzgfclzm9Asf"

public enum ClientError: Error {
    case couldNotDecodeJSON
    case badStatus(Int, String)
}

public final class Client {
    
    // MARK: - Properties
    private let fetcher: HTTPFetcher
    
    public init(fetcher: HTTPFetcher = URLSession(configuration: URLSessionConfiguration.default)){
        self.fetcher = fetcher
        
    }
    
    private func response(forResource resource: Resource) -> Observable<Response> {
        // 1. creamos el request
        let request = resource.request(withBaseUrl: baseURL, additionalParameters: ["KEY" : key])
        
        //2. ejecutar la request
        return fetcher.data(request: request)
            //3 transformar la data que nos devuelve el fetcher a un response
            .map { data in
                // Usamos la función decode porque ésta devuelve un objeto que implementa JSONDecodable, y Response lo es.
                guard let response : Response = decode(data) else {
                    throw ClientError.couldNotDecodeJSON
                }
                //                guard response.succeeded else {
                //                    throw ClientError.badStatus(response.status, response.message)
                //                }
                // devuelvo el response para que el map sea Observable<Response>
                // El map siempre devuelve un observable y lo que tienes que devolver es lo que va en los <> (Observable<Response> en este caso)
                return response
                
        }
    }
    
    
    /// Función que recibe un Resource y devuelve un Observable de un objeto que implementa el protocolo JSONDecodable
    public func object<T: JSONDecodable>(forResource resource: Resource) -> Observable<T> {
        
        return response(forResource: resource)
            .map { response in
                guard let result: T = response.result() else {
                    throw ClientError.couldNotDecodeJSON
                }
                return result
        }
    }
    /// Función que recibe un Resource y devuelve un Observable de un array de objetos que implementan el protocolo JSONDecodable
    public func objects<T: JSONDecodable>(forResource resource: Resource) -> Observable<[T]> {
        
        return response(forResource: resource)
            .map { response in
                guard let results: [T] = response.results() else {
                    throw ClientError.couldNotDecodeJSON
                }
                return results
        }
    }
    
}

