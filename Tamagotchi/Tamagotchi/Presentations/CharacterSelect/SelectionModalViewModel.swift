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
        let selectCharacter: Driver<TamagotchiCharacter>
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
        
        selectCharacter.bind { character in
            UserDefaultsManager.shared.character.character = character
            UserDefaultsManager.shared.isOnboarding = false
        }
        .disposed(by: disposeBag)
        
        let output = Output(
            selectButtonTitle: selectButtonTitle,
            character: characterRelay,
            selectCharacter: selectCharacter.asDriver(onErrorJustReturn: .notReady),
            cancel: input.cancel.asDriver()
        )
        
        return output
    }
}
