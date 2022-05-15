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
    let homeImageURL: String
        
    enum ContainerKeys: String, CodingKey {
        case other
    }
    
    enum OtherKeys: String, CodingKey {
        case home
    }
    
    enum HomeKeys: String, CodingKey {
        case frontImageURL = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        let otherContainer = try container.nestedContainer(keyedBy: OtherKeys.self, forKey: .other)
        let homeContainer = try otherContainer.nestedContainer(keyedBy: HomeKeys.self, forKey: .home)
        
        self.homeImageURL = try homeContainer.decode(String.self, forKey: .frontImageURL)
    }
}
