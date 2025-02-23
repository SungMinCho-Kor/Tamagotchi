//
//  BaseTableViewCell.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/23/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ViewConfiguration, ReuseIdentifiable {
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
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
