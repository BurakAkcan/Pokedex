//
//  PokemonStatTableViewCell.swift
//  Pokedex
//
//  Created by Mustafa on 15.05.2022.
//

import UIKit

class PokemonStatTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var valueLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    func customInit() {
        loadNameLabel()
        loadValueLabel()
        
        loadNameLabelConstraints()
        loadValueLabelConstraints()
    }
}

// MARK: - View Loaders
extension PokemonStatTableViewCell {
    func loadNameLabel() {
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
    }
    
    func loadValueLabel() {
        valueLabel = UILabel()
        contentView.addSubview(valueLabel)
    }
}

// MARK: - View Constraints Loaders
extension PokemonStatTableViewCell {
    func loadNameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.offset)
            make.centerY.equalToSuperview()
        }
    }
    
    func loadValueLabelConstraints() {
        valueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Constants.offset)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - Configurations
extension PokemonStatTableViewCell {
    
    /// sets statistics name and value in the cell
    /// - Parameters:
    ///   - name: name of the statistics
    ///   - value: value of the statistics
    func setContent(name: String, value: Int) {
        nameLabel.text = name
        valueLabel.text = "\(value)"
    }
}

// MARK: - Constants {
extension PokemonStatTableViewCell {
    enum Constants {
        static let cellIdentifier = "PokemonStatTableViewCell"
        static let offset: CGFloat = 30
    }
}
