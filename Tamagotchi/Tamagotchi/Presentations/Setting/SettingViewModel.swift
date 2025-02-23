//
//  SettingViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let cellSelected: ControlEvent<IndexPath>
    }
    
    struct Output {
        let tableViewItems: BehaviorRelay<[SettingCellContent]>
        let pushChangeMasterNameViewController: PublishRelay<Void>
        let pushChangeTamagochiViewController: PublishRelay<Void>
        let presentResetAlert: PublishRelay<Void>
    }
    
    func transform(input: Input) -> Output {
        let pushChangeMasterNameViewController = PublishRelay<Void>()
        let pushChangeTamagochiViewController = PublishRelay<Void>()
        let presentResetAlert = PublishRelay<Void>()
        
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
        
        input.cellSelected
            .bind { indexPath in
                switch indexPath.row {
                case 0:
                    pushChangeMasterNameViewController.accept(())
                case 1:
                    pushChangeTamagochiViewController.accept(())
                case 2:
                    presentResetAlert.accept(())
                default:
                    print("Cell Selection Error")
                }
            }
            .disposed(by: disposeBag)
        
        let output = Output(
            tableViewItems: tableViewItems,
            pushChangeMasterNameViewController: pushChangeMasterNameViewController,
            pushChangeTamagochiViewController: pushChangeTamagochiViewController,
            presentResetAlert: presentResetAlert
        )
        
        return output
    }
}
