//
//  CharacterView.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import UIKit

final class CharacterView: BaseView {
    private let characterImageView = UIImageView()
    private let characterNameLabelView = BorderLabelView()
    
    override func configureHierarchy() {
        [
            characterImageView,
            characterNameLabelView
        ].forEach(addSubview)
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
    
    func configure(imageName: String, name: String) {
        characterImageView.image = UIImage(named: imageName)
        characterNameLabelView.setTitle(name)
    }
    
    func reset() {
        characterImageView.image = nil
        characterNameLabelView.setTitle("")
    }
}
