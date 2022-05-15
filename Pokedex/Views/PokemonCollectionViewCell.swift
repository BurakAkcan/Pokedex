//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Mustafa on 14.05.2022.
//

import UIKit
import SDWebImage

class PokemonCollectionViewCell: UICollectionViewCell {
    private var spriteImageView: UIImageView!
    private var nameLabel: UILabel!
    private var idLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    func customInit() {
        configureCell()
        
        loadSpriteImageView()
        loadNameLabel()
        loadIdLabel()
        
        loadSpriteImageViewConstraints()
        loadNameLabelConstraints()
        loadIdLabelConstraints()
    }
}

// MARK: - Configurations
extension PokemonCollectionViewCell {
    /// configures cell appearance
    func configureCell() {
        contentView.backgroundColor = Constants.backgroundColor
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
    
    /// sets pokemon name and image to the appropriate views
    /// - Parameters:
    ///   - id: id of the pokemon
    ///   - name: name of the pokemon
    ///   - imageURL: URL that contains the image of the pokemon
    func setContent(id: Int, name: String, imageURL: URL?) {
        spriteImageView.sd_setImage(with: imageURL)
        idLabel.text = "#\(id)"
        nameLabel.text = name
    }
}

// MARK: - View Loaders
extension PokemonCollectionViewCell {
    func loadSpriteImageView() {
        spriteImageView = UIImageView()
        addSubview(spriteImageView)
    }
    
    func loadNameLabel() {
        nameLabel = UILabel()
        nameLabel.textColor = Constants.NameLabel.color
        nameLabel.font = Constants.NameLabel.font
        addSubview(nameLabel)
    }
    
    func loadIdLabel() {
        idLabel = UILabel()
        idLabel.textColor = Constants.IdLabel.color
        idLabel.font = Constants.IdLabel.font
        addSubview(idLabel)
    }
}

// MARK: - View Constraints Loaders
extension PokemonCollectionViewCell {
    func loadSpriteImageViewConstraints() {
        spriteImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.SpriteImageView.offset)
            make.top.equalToSuperview().offset(Constants.SpriteImageView.offset)
            make.trailing.equalToSuperview().offset(-Constants.SpriteImageView.offset)
            make.bottom.equalToSuperview().offset(-Constants.SpriteImageView.offset)
        }
    }
    
    func loadNameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.NameLabel.topOffset)
            make.centerX.equalToSuperview()
        }
    }
    
    func loadIdLabelConstraints() {
        idLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(Constants.IdLabel.offset)
        }
    }
}

// MARK: - Constants
extension PokemonCollectionViewCell {
    
    /// contains the constant values used in the cell
    enum Constants {
        static let cellIdentifier = "pokemonCollectionViewCell"
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .orange
        
        enum SpriteImageView {
            static let offset: CGFloat = 30
        }
        
        enum NameLabel {
            static let topOffset: CGFloat = 10
            static let color: UIColor = .white
            static let font: UIFont = .boldSystemFont(ofSize: 20)
        }
        
        enum IdLabel {
            static let offset: CGFloat = -10
            static let color: UIColor = .white
            static let font: UIFont = .boldSystemFont(ofSize: 16)
        }
    }
}
