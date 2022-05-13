//
//  Endpoint.swift
//  Pokedex
//
//  Created by Mustafa on 13.05.2022.
//

import Foundation

/// A protocol that defines the attributes of an API endpoint
protocol Endpoint {
    
    /// scheme component of the URL
    var scheme: String { get }
    
    /// host component of the URL
    var host: String { get }
    
    /// base path prefix used for all endpoints
    var basePath: String { get }
    
    /// path for the endpoint
    var path: String { get }
    
    /// http method for the endpoint
    var httpMethod: HTTPMethod { get }
}

// MARK: - Default Values
extension Endpoint {
    var scheme: String { "https" }
    var host: String { "pokeapi.co" }
    var basePath: String { "/api/v2" }
    var httpMethod: HTTPMethod { .get }
}

// MARK: - URL Formation
extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = basePath.appending(path)
        
        return urlComponents.url
    }
}
