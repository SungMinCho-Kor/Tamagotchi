//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/23/25.
//

import UIKit
import SnapKit

final class SettingTableViewCell: BaseTableViewCell, CellConfigurable {
    typealias Content = SettingCellContent
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let accessoryImageView = UIImageView()
    private let accessoryLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = ""
        accessoryLabel.text = ""
    }
    
    override func configureHierarchy() {
        [
            iconImageView,
            titleLabel,
            accessoryImageView,
            accessoryLabel
        ].forEach(contentView.addSubview)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        accessoryLabel.snp.makeConstraints { make in
            make.trailing.equalTo(accessoryImageView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureViews() {
        backgroundColor = .serviceBackground
        selectionStyle = .none
        
        iconImageView.tintColor = .servicePrimary
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .systemFont(
            ofSize: 15,
            weight: .bold
        )
        titleLabel.textColor = .black
        
        accessoryLabel.font = .systemFont(ofSize: 14)
        accessoryLabel.textColor = .servicePrimary

        accessoryImageView.tintColor = .lightGray
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryImageView.image = UIImage(systemName: "chevron.right")
    }
    
    func configure(content: Content) {
        iconImageView.image = UIImage(systemName: content.iconImageName)
        titleLabel.text = content.title
        accessoryLabel.text = content.accessoryText
    }
}
