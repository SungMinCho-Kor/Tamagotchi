//
//  BubbleView.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

import UIKit
import SnapKit

final class BubbleView: BaseView {
    private let bubbleImageView = UIImageView(image: .bubble)
    let contentLabel = UILabel()
    
    override func configureHierarchy() {
        [
            bubbleImageView,
            contentLabel
        ].forEach(addSubview)
    }
    
    override func configureLayout() {
        bubbleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(60)
        }
    }
    
    override func configureViews() {
        contentLabel.textColor = .servicePrimary
        contentLabel.textAlignment = .center
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        
        bubbleImageView.contentMode = .scaleToFill
    }
}

