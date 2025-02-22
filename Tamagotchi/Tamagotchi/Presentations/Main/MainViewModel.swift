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
        let fetchCharacter: BehaviorRelay<CharacterInformation>
        let navigationTitle: BehaviorRelay<String>
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
        
        let output = Output(
            fetchCharacter: character,
            navigationTitle: navigationTitle
        )
        
        return output
    }
}
