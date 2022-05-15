//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Mustafa on 15.05.2022.
//

import Foundation

/// A struct that stores statistics of a pokemon
struct PokemonStat: Decodable {
    /// name of the statistics
    let name: String
    
    /// value of the statistics
    let value: Int
    
    enum ContainerKeys: String, CodingKey {
        case value = "base_stat"
        case stat
    }
    
    enum StatKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        let statContainer = try container.nestedContainer(keyedBy: StatKeys.self, forKey: .stat)
        
        self.name = try statContainer.decode(String.self, forKey: .name)
        self.value = try container.decode(Int.self, forKey: .value)
    }
    
}
