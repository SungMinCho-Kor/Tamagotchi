//
//  MainViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

import RxSwift
import RxCocoa

final class MainViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let waterText: BehaviorRelay<String>
        let waterTapped: ControlEvent<Void>
        let foodText: BehaviorRelay<String>
        let foodTapped: ControlEvent<Void>
    }
    
    struct Output {
        let fetchCharacter: BehaviorRelay<CharacterInformation>
        let navigationTitle: BehaviorRelay<String>
        let showAlert: Driver<String>
        let showMessage: Driver<String>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: "\(UserDefaultsManager.shared.masterName)님의 다마고치")
        let character = BehaviorRelay(value: UserDefaultsManager.shared.character)
        let showAlert = PublishRelay<String>()
        let showMessage = BehaviorRelay(value: "\(UserDefaultsManager.shared.masterName)님 반가워요~")
        
        // TODO: water, food 매개변수로 통합 (중복 코드 제거)
        input.waterTapped
            .withLatestFrom(input.waterText)
            .map { amount in
                if amount.isEmpty {
                    return 1
                } else if let amount = Int(amount) {
                    return amount
                } else {
                    return -1
                }
            }
            .bind(with: self) { owner, amount in
                let prevLevel = UserDefaultsManager.shared.character.level
                if amount >= 50 || amount < 0 {
                    showAlert.accept(FeedType.water.amountWarning)
                } else {
                    UserDefaultsManager.shared.character.water += amount
                    character.accept(UserDefaultsManager.shared.character)
                }
                input.waterText.accept("")
                let currentLevel = UserDefaultsManager.shared.character.level
                if prevLevel != currentLevel {
                    showMessage.accept("물 마셔서, 레벨업했어요 \(UserDefaultsManager.shared.masterName)님!")
                } else {
                    let waterMessages = [
                        "물 주셔서 감사합니다 \(UserDefaultsManager.shared.masterName)님!",
                        "물 맛있어요 \(UserDefaultsManager.shared.masterName)님!",
                        "물 꿀꺽꿀꺽..",
                    ]
                    showMessage.accept(waterMessages.randomElement()!)
                }
            }
            .disposed(by: disposeBag)
        
        input.foodTapped
            .withLatestFrom(input.foodText)
            .map { amount in
                if amount.isEmpty {
                    return 1
                } else if let amount = Int(amount) {
                    return amount
                } else {
                    return -1
                }
            }
            .bind(with: self) { owner, amount in
                let prevLevel = UserDefaultsManager.shared.character.level
                if amount >= 100 || amount < 0 {
                    showAlert.accept(FeedType.food.amountWarning)
                } else {
                    UserDefaultsManager.shared.character.food += amount
                    character.accept(UserDefaultsManager.shared.character)
                }
                input.foodText.accept("")
                let currentLevel = UserDefaultsManager.shared.character.level
                if prevLevel != currentLevel {
                    showMessage.accept("밥 먹어서, 레벨업했어요 \(UserDefaultsManager.shared.masterName)님!")
                } else {
                    let foodMessages = [
                        "밥 주셔서 감사합니다 \(UserDefaultsManager.shared.masterName)님!",
                        "밥 맛있어요 \(UserDefaultsManager.shared.masterName)님!",
                        "밥 냠냠..",
                        "배 불러요 \(UserDefaultsManager.shared.masterName)님 감사해요"
                    ]
                    showMessage.accept(foodMessages.randomElement()!)
                }
            }
            .disposed(by: disposeBag)
            
        let output = Output(
            fetchCharacter: character,
            navigationTitle: navigationTitle,
            showAlert: showAlert.asDriver(onErrorJustReturn: "입력이 잘못됐어요"),
            showMessage: showMessage.asDriver(onErrorJustReturn: "좋은 하루에요")
        )
        
        return output
    }
}
