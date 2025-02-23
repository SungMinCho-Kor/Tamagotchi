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
    struct Input {
        let cellSelected: ControlEvent<IndexPath>
        let refresh: PublishRelay<Void>
    }
    
    struct Output {
        let tableViewItems: PublishRelay<[SettingCellContent]>
        let pushChangeMasterNameViewController: PublishRelay<Void>
        let pushChangeTamagochiViewController: PublishRelay<Void>
        let presentResetAlert: PublishRelay<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let pushChangeMasterNameViewController = PublishRelay<Void>()
        let pushChangeTamagochiViewController = PublishRelay<Void>()
        let presentResetAlert = PublishRelay<Void>()
        
        var cellContents: [SettingCellContent] = [
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
        
        let tableViewItems = PublishRelay<[SettingCellContent]>()
        
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
        
        input.refresh
            .bind { _ in
                cellContents[0] = SettingCellContent(
                    iconImageName: "pencil",
                    title: "내 이름 설정하기",
                    accessoryText: UserDefaultsManager.shared.masterName
                )
                tableViewItems.accept(cellContents)
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
