//
//  PokemonEndpoint.swift
//  Pokedex
//
//  Created by Mustafa on 13.05.2022.
//

import Foundation

/// An enum that contains pokemon endpoints
enum PokemonEndpoint: Endpoint {
    /// endpoint that represents the path: ```/pokemon```
    case pokemons
    
    /// endpoint that represents the path: ```/pokemon/{name}```
    case pokemon(name: String)
    
    var path: String {
        switch self {
        case .pokemons:
            return "/pokemon"
        case .pokemon(let name):
            return "/pokemon/".appending(name)
        }
    }
}
