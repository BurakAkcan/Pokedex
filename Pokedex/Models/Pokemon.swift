//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mustafa on 14.05.2022.
//

import Foundation

/// A struct that stores the name and the URL of a pokemon
struct Pokemon: Decodable {
    /// name of the pokemon
    let name: String
    
    /// endpoint URL for the pokemon
    let url: String
}
