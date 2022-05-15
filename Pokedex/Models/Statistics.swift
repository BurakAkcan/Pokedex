//
//  Statistics.swift
//  Pokedex
//
//  Created by Mustafa on 15.05.2022.
//

import Foundation

/// A struct that stores all the statistics of a pokemon shown on the detail screen
struct Statistics {
    /// name of the statistics
    let name: String
    
    /// value of the statistics
    let value: Int
    
    /// formatted version of the name if it consists of multiple words
    var formattedName: String {
        name.split(separator: "-").map { $0.capitalized }.joined(separator: " ")
    }
}
