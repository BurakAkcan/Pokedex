//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Mustafa on 14.05.2022.
//

import Foundation

// A singleton that manages pokemon requests
final class PokemonManager {
    
    static let shared = PokemonManager()
    
    private init() { } // prevents any instantiation other than the shared instance
    
    
    /// fetches a list of pokemon details from the API asynchronously, sorts them by their ids, calls the completion handler with the final list
    /// - Parameter completion: completion handler that receives a list of pokemon details when all responses for the pokemons are received
    func getPokemonDetails(completion: @escaping ([PokemonDetail]?) -> ()) {
        PokemonManager.shared.getBatchOfPokemons { pokemonBatch in
            guard let pokemonBatch = pokemonBatch else {
                completion(nil)
                return
            }
            
            let group = DispatchGroup()
            var pokemonDetails: [PokemonDetail] = []
            
            for pokemon in pokemonBatch.pokemons {
                group.enter()
                PokemonManager.shared.getPokemonDetail(for: pokemon.name) { pokemonDetail in
                    if let pokemonDetail = pokemonDetail {
                        pokemonDetails.append(pokemonDetail)
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                pokemonDetails.sort { $0.id < $1.id }
                completion(pokemonDetails.count != 0 ? pokemonDetails : nil)
            }
        }
    }
    
    /// fetches a batch of pokemons from the API
    /// - Parameter completion: completion handler that receives a PokemonBatch instance  if the request is completed successfully, otherwise receives nil
    func getBatchOfPokemons(completion: @escaping (PokemonBatch?) -> ()) {
        let pokemonsEndpoint: PokemonEndpoint = .pokemons
        
        NetworkManager.request(endpoint: pokemonsEndpoint) { (response: Result<PokemonBatch, ServiceError>) in
            switch response {
            case .success(let pokemonBatch):
                completion(pokemonBatch)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    /// fetches the detail for a pokemon from the API
    /// - Parameters:
    ///   - name: name of the pokemon whose details are requested
    ///   - completion: completion handler that receives a PokemonDetail instance if the request is completed successfully, otherwise receives nil
    func getPokemonDetail(for name: String, completion: @escaping (PokemonDetail?) -> ()) {
        let pokemonEndpoint: PokemonEndpoint = .pokemon(name: name)
        
        NetworkManager.request(endpoint: pokemonEndpoint) { (response: Result<PokemonDetail, ServiceError>) in
            switch response {
            case .success(let pokemonDetail):
                completion(pokemonDetail)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
