//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Mustafa on 15.05.2022.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var idLabel: UILabel!
    var spriteImageView: UIImageView!
    var infoContainer: UIView!
    var nameLabel: UILabel!
    var statsTableView: UITableView!
    
    var pokemon: PokemonDetail!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()

        loadIdLabel()
        loadSpriteImageView()
        loadInfoContainer()
        loadNameLabel()
        loadStatsTableView()
        
        loadIdLabelConstraints()
        loadSpriteImageViewConstraints()
        loadInfoContainerConstraints()
        loadNameLabelConstraints()
        loadStatsTableViewConstraints()
    }
}

// MARK: - Configurations
extension PokemonDetailViewController {
    func configureViewController() {
        view.backgroundColor = Constants.backgroundColor
    }
}

// MARK: - View Loaders
extension PokemonDetailViewController {
    func loadIdLabel() {
        idLabel = UILabel()
        idLabel.font = Constants.IdLabel.font
        idLabel.text = "#\(pokemon.id)"
        view.addSubview(idLabel)
    }
    
    func loadSpriteImageView() {
        spriteImageView = UIImageView()
        spriteImageView.sd_setImage(with: URL(string: pokemon.sprites.homeImageURL))
        view.addSubview(spriteImageView)
    }
    
    func loadInfoContainer() {
        infoContainer = UIView()
        infoContainer.backgroundColor = Constants.InfoContainer.backgroundColor
        infoContainer.clipsToBounds = true
        infoContainer.layer.cornerRadius = Constants.InfoContainer.cornerRadius
        infoContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(infoContainer)
        view.sendSubviewToBack(infoContainer)
    }
    
    func loadNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = Constants.NameLabel.font
        nameLabel.text = pokemon.name.capitalized
        
        infoContainer.addSubview(nameLabel)
    }
    
    func loadStatsTableView() {
        statsTableView = UITableView()
        statsTableView.backgroundColor = Constants.StatsTableView.backgroundColor
        statsTableView.dataSource = self
        statsTableView.register(PokemonStatTableViewCell.self, forCellReuseIdentifier: PokemonStatTableViewCell.Constants.cellIdentifier)
        statsTableView.allowsSelection = false
        statsTableView.rowHeight = Constants.StatsTableView.rowHeight
        infoContainer.addSubview(statsTableView)
    }
}

// MARK: - View Constraints Loaders
extension PokemonDetailViewController {
    func loadIdLabelConstraints() {
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(Constants.IdLabel.trailingOffset)
        }
    }
    
    func loadSpriteImageViewConstraints() {
        spriteImageView.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom)
            make.size.equalTo(Constants.SpriteImageView.size)
            make.centerX.equalToSuperview()
        }
    }
    
    func loadInfoContainerConstraints() {
        infoContainer.snp.makeConstraints { make in
            make.top.equalTo(spriteImageView.snp.bottom).offset(Constants.InfoContainer.topOffset)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func loadNameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.NameLabel.topOffset)
            make.centerX.equalToSuperview()
        }
    }
    
    func loadStatsTableViewConstraints() {
        statsTableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.StatsTableView.topOffset)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Data Source
extension PokemonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonStatTableViewCell.Constants.cellIdentifier, for: indexPath) as? PokemonStatTableViewCell
        else { return UITableViewCell() }
        
        let stat = stats[indexPath.row]
        
        cell.setContent(name: stat.formattedName, value: stat.value)
        
        return cell
    }
}

// MARK: - Constants
extension PokemonDetailViewController {
    enum Constants {
        static let backgroundColor = UIColor(named: "mainOrange") ?? UIColor.orange
        
        enum IdLabel {
            static let font: UIFont = .boldSystemFont(ofSize: 25)
            static let trailingOffset: CGFloat = -20
        }
        
        enum SpriteImageView {
            static let size = CGSize(width: 300, height: 300)
        }
        
        enum NameLabel {
            static let font: UIFont = .boldSystemFont(ofSize: 25)
            static let topOffset: CGFloat = 35
        }
        
        enum InfoContainer {
            static let backgroundColor = UIColor(named: "primaryColor") ?? UIColor.white
            static let cornerRadius: CGFloat = 20
            static let topOffset: CGFloat = -25
        }
        
        enum StatsTableView {
            static let rowHeight: CGFloat = 50
            static let topOffset: CGFloat = 20
            static let backgroundColor = UIColor(named: "primaryColor") ?? UIColor.white
        }
    }
}

