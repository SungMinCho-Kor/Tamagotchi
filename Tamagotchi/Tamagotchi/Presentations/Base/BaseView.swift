//
//  BaseView.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import UIKit

class BaseView: UIView {
    init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        configureViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureViews() { }
}
