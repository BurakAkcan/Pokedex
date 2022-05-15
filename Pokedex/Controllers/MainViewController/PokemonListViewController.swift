//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Mustafa on 13.05.2022.
//

import UIKit
import SnapKit
import SVProgressHUD

class PokemonListViewController: UIViewController {
    
    private var pokemonCollectionView: UICollectionView!
    private var searchController: UISearchController!
    
    private var pokemons: [PokemonDetail] = []
    
    private var filteredPokemons: [PokemonDetail] = []
    
    /// determines whether the user is currently searching for an pokemon or not
    private var isInSearchMode: Bool {
        searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        
        loadPokemonCollectionView()
        loadPokemonCollectionViewConstraints()
    }
}

// MARK: - Configurations
extension PokemonListViewController {
    func configureViewController() {
        // view configurations
        view.backgroundColor = .white
        definesPresentationContext = true
        
        // navigation bar configurations
        title = Constants.NavigationBar.navigationTitle
        navigationItem.hidesSearchBarWhenScrolling = true
        
        // configurations for progress hud
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundLayerColor(Constants.ProgressHUD.backgroundLayerColor)
        
        // request pokemon details
        SVProgressHUD.show()
        
        PokemonManager.shared.getPokemonDetails { pokemonDetails in
            if let pokemonDetails = pokemonDetails {
                self.pokemons = pokemonDetails
                self.pokemonCollectionView.reloadData()
            }
            
            SVProgressHUD.dismiss()
        }
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

// MARK: - View Loaders
extension PokemonListViewController {
    func loadPokemonCollectionView() {
        let layout = createFlowLayout()
        
        pokemonCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.Constants.cellIdentifier)
        pokemonCollectionView.alwaysBounceVertical = true
        pokemonCollectionView.keyboardDismissMode = .onDrag
        
        view.addSubview(pokemonCollectionView)
    }
}

// MARK: - View Constraints Loaders
extension PokemonListViewController {
    func loadPokemonCollectionViewConstraints() {
        pokemonCollectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - CollectionView Data Source
extension PokemonListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isInSearchMode ? filteredPokemons.count : pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.Constants.cellIdentifier,
                                                            for: indexPath) as? PokemonCollectionViewCell
        else { return UICollectionViewCell() }
        
        let pokemon = isInSearchMode ? filteredPokemons[indexPath.item] : pokemons[indexPath.item]
        let imageURL = URL(string: pokemon.sprites.homeImageURL)
        cell.setContent(name: pokemon.name, imageURL: imageURL)
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension PokemonListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPokemon = isInSearchMode ? filteredPokemons[indexPath.item] : pokemons[indexPath.item]
        
        let detailViewController = PokemonDetailViewController()
        detailViewController.pokemon = selectedPokemon
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - CollectionView Flow Layout
extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing = Constants.PokemonCollectionView.spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = Constants.PokemonCollectionView.spacing * (Constants.PokemonCollectionView.numberOfItemsInARow + 1)
        let itemWidth: CGFloat = (collectionView.bounds.width - totalSpacing) / Constants.PokemonCollectionView.numberOfItemsInARow
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

// MARK: - UISearchResultsUpdating
extension PokemonListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
                
        filteredPokemons = pokemons.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        pokemonCollectionView.reloadData()
    }
}

// MARK: - Constants
extension PokemonListViewController {
    
    /// contains the constant values used in the view controller
    enum Constants {
        enum NavigationBar {
            static let navigationTitle = "Pokedex"
        }
        
        enum PokemonCollectionView {
            static let spacing: CGFloat = 30
            static let numberOfItemsInARow: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
        }
        
        enum ProgressHUD {
            static let backgroundLayerColor: UIColor = .black.withAlphaComponent(0.5)
        }
    }
}
