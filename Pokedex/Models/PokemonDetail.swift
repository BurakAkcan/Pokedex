//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Mustafa on 14.05.2022.
//

import Foundation

/**
    A struct that stores detailed information about a pokemon.
 
    There are more attributes than those listed in this model.
    To see all available attributes, visit https://pokeapi.co/docs/v2#pokemon
*/
struct PokemonDetail: Decodable {
    /// id of the pokemon
    let id: Int
    
    /// name of the pokemon
    let name: String
    
    /// base experience for defeating the pokemon
    let baseExperience: Int
    
    /// height of the pokemon
    let height: Int
    
    /// weight of the pokemon
    let weight: Int
    
    /// sprites of the pokemon containing image URLs
    let sprites: PokemonSprites
    
    /// stats of the pokemon
    let stats: [PokemonStat]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case weight
        case sprites
        case stats
    }
}
