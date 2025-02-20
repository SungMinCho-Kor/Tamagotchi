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
        
    }
    
    struct Output {
        let characters: BehaviorRelay<[TamagotchiCharacter]>
        let navigationTitle: Observable<String>
    }
    
    private let isOnboarding: Bool
    
    init(isOnboarding: Bool) {
        self.isOnboarding = isOnboarding
    }
    
    private let characters: TamagotchiCharacters = TamagotchiCharacters()
    
    func transform(input: Input) -> Output {
        let output = Output(
            characters: BehaviorRelay(value: characters.list),
            navigationTitle: Observable.just(isOnboarding ? "다마고치 선택하기" : "다마고치 변경하기")
        )
        
        return output
    }
}
