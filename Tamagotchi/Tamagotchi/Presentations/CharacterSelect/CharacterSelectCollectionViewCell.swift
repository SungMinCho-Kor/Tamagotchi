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
    
    private let characterImageView = UIImageView()
    private let characterNameLabelView = BorderLabelView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = .no
        characterNameLabelView.setTitle("")
    }
    
    override func configureHierarchy() {
        [
            characterImageView,
            characterNameLabelView
        ].forEach(contentView.addSubview)
    }
    
    override func configureLayout() {
        characterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(characterImageView.snp.width)
        }
        
        characterNameLabelView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(36)
        }
    }
    
    override func configureViews() {
        backgroundColor = .clear
    }
    
    func configure(content: Content) {
        characterImageView.image = UIImage(named: content.imageName)
        characterNameLabelView.setTitle(content.name)
    }
}
