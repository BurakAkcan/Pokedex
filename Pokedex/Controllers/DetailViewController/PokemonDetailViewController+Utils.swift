//
//  PokemonDetailViewController+Utils.swift
//  Pokedex
//
//  Created by Mustafa on 15.05.2022.
//

extension PokemonDetailViewController {
    var stats: [Statistics] {
        var stats: [Statistics] = []
        
        // add basic statistics
        stats.append(Statistics(name: "Base Experience", value: pokemon.baseExperience))
        stats.append(Statistics(name: "Height", value: pokemon.height))
        stats.append(Statistics(name: "Weight", value: pokemon.weight))
        
        // add additional statistics, if any
        for stat in pokemon.stats {
            stats.append(Statistics(name: stat.name, value: stat.value))
        }
        
        return stats
    }
}

