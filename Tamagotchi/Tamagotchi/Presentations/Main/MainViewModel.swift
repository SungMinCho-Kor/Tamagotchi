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
        let fetchCharacter: Observable<TamagotchiCharacter>
    }
    
    private let character: TamagotchiCharacter
    
    init(character: TamagotchiCharacter) {
        self.character = character
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let output = Output(
            fetchCharacter: Observable.just(character)
        )
        
        return output
    }
}
