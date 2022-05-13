//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Mustafa on 13.05.2022.
//

import Foundation

/// A class that handles network requests
class NetworkManager {
    
    /// sends a network request to the provided endpoint, decodes the response based on the ResponseType, and calls completion handler with the decoded data or error
    /// - Parameters:
    ///   - endpoint: API endpoint to which the request is sent
    ///   - completion: completion handler that is called when a result is received or an error occurs
    static func request<ResponseType: Decodable>(endpoint: Endpoint, completion: @escaping (Result<ResponseType, ServiceError>) -> ()) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURLError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.httpResponseError(statusCode: (response as? HTTPURLResponse)?.statusCode)))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(ResponseType.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(data: data)))
                }
            }
        }
        
        task.resume()
    }
}
