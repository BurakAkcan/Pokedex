//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Mustafa on 13.05.2022.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Constants.NavigationBar.navigationTitle
    }
}

// MARK: - Constants
extension PokemonSearchViewController {
    
    /// contains the constant values used in the view controller
    enum Constants {
        enum NavigationBar {
            static let navigationTitle = "Pokedex"
        }
    }
}
