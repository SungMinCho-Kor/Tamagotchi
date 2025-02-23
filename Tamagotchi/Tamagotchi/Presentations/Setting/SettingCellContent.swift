//
//  SettingCellContent.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/23/25.
//

struct SettingCellContent {
    let iconImageName: String
    let title: String
    let accessoryText: String?
    
    init(
        iconImageName: String,
        title: String,
        accessoryText: String? = nil
    ) {
        self.iconImageName = iconImageName
        self.title = title
        self.accessoryText = accessoryText
    }
}
