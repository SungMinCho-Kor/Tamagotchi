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
        let navigationTitle: Observable<String>
        let showSelectView: PublishRelay<TamagotchiCharacter>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    private let disposeBag = DisposeBag()
    private let characters: TamagotchiCharacters = TamagotchiCharacters()
    
    func transform(input: Input) -> Output {
        let showSelectView = PublishRelay<TamagotchiCharacter>()
        
        let output = Output(
            characters: BehaviorRelay(value: characters.list),
            navigationTitle: Observable.just(UserDefaultsManager.shared.isOnboarding ? "다마고치 선택하기" : "다마고치 변경하기"),
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
