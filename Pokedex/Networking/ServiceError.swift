//
//  ServiceError.swift
//  Pokedex
//
//  Created by Mustafa on 13.05.2022.
//

import Foundation


/// An enum containing different error cases that may occur during network requests
enum ServiceError: Error, CustomStringConvertible {
    /// an error case that occurs when the endpoint URL is invalid
    case invalidURLError
    
    /// an error case that occurs when the data cannot be decoded
    case decodingError(data: Data)
    
    /// an error case that occurs when http response is erroneous
    case httpResponseError(statusCode: Int?)
    
    /// a general network error case
    case networkError
    
    var description: String {
        switch self {
        case .invalidURLError:
            return "Invalid URL error occured!"
        case .networkError:
            return "Network error occured!"
        case .decodingError(let data):
            return "Decoding error occured! (Data: \(data))"
        case .httpResponseError(let statusCode):
            return "HTTP response error occured!" + (statusCode != nil ? "(status code: \(statusCode!))" : "")
        }
    }
}
