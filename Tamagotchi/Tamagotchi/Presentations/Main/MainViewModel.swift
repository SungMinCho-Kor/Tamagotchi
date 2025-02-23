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
    }
    
    struct Output {
        let fetchCharacter: BehaviorRelay<CharacterInformation>
        let navigationTitle: BehaviorRelay<String>
        let showAlert: Driver<String>
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
        
        input.waterTapped
            .withLatestFrom(input.waterText)
            .map { amount in
                if amount.isEmpty {
                    return 1
                } else if let amount = Int(amount) {
                    return amount
                } else {
                    showAlert.accept(FeedType.water.amountWarning)
                    return 0
                }
            }
            .bind(with: self) { owner, amount in
                if amount >= 50 || amount < 0 {
                    showAlert.accept(FeedType.water.amountWarning)
                } else {
                    UserDefaultsManager.shared.character.water += amount
                    character.accept(UserDefaultsManager.shared.character)
                }
                input.waterText.accept("")
            }
            .disposed(by: disposeBag)
            
        let output = Output(
            fetchCharacter: character,
            navigationTitle: navigationTitle,
            showAlert: showAlert.asDriver(onErrorJustReturn: "입력이 잘못됐어요")
        )
        
        return output
    }
}
