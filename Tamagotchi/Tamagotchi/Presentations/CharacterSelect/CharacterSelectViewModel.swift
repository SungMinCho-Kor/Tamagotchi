//
//  CharacterSelectViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import RxSwift
import RxCocoa

final class CharacterSelectViewModel: ViewModel {
    struct Input {
        let cellSelected: ControlEvent<TamagotchiCharacter>
    }
    
    struct Output {
        let characters: BehaviorRelay<[TamagotchiCharacter]>
        let navigationTitle: BehaviorRelay<String>
        let showSelectView: PublishRelay<TamagotchiCharacter>
    }
    
    private let disposeBag = DisposeBag()
    private let characters: TamagotchiCharacters = TamagotchiCharacters()
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let showSelectView = PublishRelay<TamagotchiCharacter>()
        let navigationTitle = BehaviorRelay(value: UserDefaultsManager.shared.isOnboarding ? "다마고치 선택하기" : "다마고치 변경하기")
        
        let output = Output(
            characters: BehaviorRelay(value: characters.list),
            navigationTitle: navigationTitle,
            showSelectView: showSelectView
        )
        
        input.cellSelected
            .bind(with: self) { owner, character in
                if character != TamagotchiCharacter.notReady {
                    showSelectView.accept(character)
                }
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
