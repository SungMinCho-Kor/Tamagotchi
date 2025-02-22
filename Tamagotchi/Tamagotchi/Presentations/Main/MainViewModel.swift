//
//  MainViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

import RxSwift
import RxCocoa

final class MainViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        let fetchCharacter: Driver<CharacterInformation>
        let navigationTitle: BehaviorRelay<String>
    }
    
    private var character: CharacterInformation = UserDefaultsManager.shared.character
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: UserDefaultsManager.shared.masterName)
        
        let output = Output(
            fetchCharacter: Observable.just(character).asDriver(
                onErrorJustReturn: CharacterInformation(
                    character: .notReady,
                    water: 0,
                    food: 0
                )
            ),
            navigationTitle: navigationTitle
        )
        
        return output
    }
}
