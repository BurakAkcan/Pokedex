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
        
        loadSpriteImageViewConstraints()
        loadNameLabelConstraints()
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
    ///   - name: name of the pokemon
    ///   - imageURL: URL that contains the image of the pokemon
    func setContent(name: String, imageURL: URL?) {
        spriteImageView.sd_setImage(with: imageURL)
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
            make.bottom.equalToSuperview().offset(Constants.NameLabel.bottomOffset)
            make.centerX.equalToSuperview()
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
            static let offset: CGFloat = 20
        }
        
        enum NameLabel {
            static let bottomOffset: CGFloat = -10
            static let color: UIColor = .white
            static let font: UIFont = .boldSystemFont(ofSize: 20)
        }
    }
}
