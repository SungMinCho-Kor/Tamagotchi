//
//  BorderLabelView.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import UIKit
import SnapKit

final class BorderLabelView: BaseView {
    private let label = UILabel()
    
    override func configureHierarchy() {
        addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    override func configureViews() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.servicePrimary.cgColor
        
        backgroundColor = .serviceDarkBackground
        clipsToBounds = true
        
        label.textColor = .servicePrimary
        label.textAlignment = .center
        label.font = .systemFont(
            ofSize: 14,
            weight: .bold
        )
    }
    
    func setTitle(_ title: String) {
        label.text = title
    }
}
