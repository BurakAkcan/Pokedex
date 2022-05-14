//
//  PokemonBatch.swift
//  Pokedex
//
//  Created by Mustafa on 14.05.2022.
//

import Foundation

/// A struct that stores information for a batch of pokemons, as well as the URL of the next batch
struct PokemonBatch: Decodable {
    /// URL for the next batch of pokemons
    let next: String
    
    /// a list of pokemons
    let pokemons: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case next
        case pokemons = "results"
    }
}
