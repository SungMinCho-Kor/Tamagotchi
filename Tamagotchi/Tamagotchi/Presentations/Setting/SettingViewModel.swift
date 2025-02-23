//
//  SettingViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/23/25.
//

import RxSwift
import RxCocoa

final class SettingViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        let tableViewItems: BehaviorRelay<[SettingCellContent]>
    }
    
    func transform(input: Input) -> Output {
        let cellContents: [SettingCellContent] = [
            SettingCellContent(
                iconImageName: "pencil",
                title: "내 이름 설정하기",
                accessoryText: UserDefaultsManager.shared.masterName
            ),
            SettingCellContent(
                iconImageName: "moon.fill",
                title: "다마고치 변경하기"
            ),
            SettingCellContent(
                iconImageName: "arrow.clockwise",
                title: "데이터 초기화"
            )
        ]
        
        let tableViewItems = BehaviorRelay(value: cellContents)
        
        let output = Output(
            tableViewItems: tableViewItems
        )
        
        return output
    }
}
