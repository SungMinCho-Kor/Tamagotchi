//
//  SelectionModalViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import RxSwift
import RxCocoa

final class SelectionModalViewModel: ViewModel {
    struct Input {
        let select: ControlEvent<Void>
        let cancel: ControlEvent<Void>
    }
    
    struct Output {
        let selectButtonTitle: BehaviorRelay<String>
        let character: BehaviorRelay<TamagotchiCharacter>
        let selectCharacterOnboarding: Driver<Void>
        let selectCharacterOnSetting: Driver<Void>
        let cancel: Driver<Void>
    }
    
    private let disposeBag = DisposeBag()
    private let character: TamagotchiCharacter
    
    init(character: TamagotchiCharacter) {
        self.character = character
        print(#function, self)
    }
    
    init() {
        self.character = UserDefaultsManager.shared.character.character
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let selectButtonTitle = BehaviorRelay(value: UserDefaultsManager.shared.isOnboarding ? "시작하기" : "변경하기")
        let characterRelay = BehaviorRelay(value: character)
        let selectCharacter = input.select
            .map { characterRelay.value }
        
        let selectOnboarding = PublishRelay<Void>()
        let selectOnSetting = PublishRelay<Void>()
        
        selectCharacter
            .bind(with: self) { owner, _ in
                UserDefaultsManager.shared.character.character = owner.character
                if UserDefaultsManager.shared.isOnboarding {
                    UserDefaultsManager.shared.isOnboarding = false
                    selectOnboarding.accept(())
                } else {
                    selectOnSetting.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        let output = Output(
            selectButtonTitle: selectButtonTitle,
            character: characterRelay,
            selectCharacterOnboarding: selectOnboarding.asDriver(onErrorJustReturn: ()),
            selectCharacterOnSetting: selectOnSetting.asDriver(onErrorJustReturn: ()),
            cancel: input.cancel.asDriver()
        )
        
        return output
    }
}
