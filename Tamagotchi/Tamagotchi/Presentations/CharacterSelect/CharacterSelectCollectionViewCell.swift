//
//  CharacterSelectCollectionViewCell.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import UIKit
import SnapKit

final class CharacterSelectCollectionViewCell: BaseCollectionViewCell, CellConfigurable {
    struct Content {
        let imageName: String
        let name: String
    }
    
    private let characterView = CharacterView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterView.reset()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(characterView)
    }
    
    override func configureLayout() {
        characterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(content: Content) {
        characterView.configure(imageName: content.imageName, name: content.name)
    }
}
