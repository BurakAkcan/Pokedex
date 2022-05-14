//
//  PokemonSprites.swift
//  Pokedex
//
//  Created by Mustafa on 14.05.2022.
//

import Foundation

/// A struct that stores pokemon sprite information
struct PokemonSprites: Decodable {
    /// URL of the front image of pokemon
    let frontImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case frontImageURL = "front_default"
    }
}
