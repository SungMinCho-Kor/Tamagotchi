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
        let selectButtonTitle: Observable<String>
        let character: Observable<TamagotchiCharacter>
        let selectCharacter: Observable<TamagotchiCharacter>
        let cancel: Observable<Void>
    }
    
    private let character: TamagotchiCharacter
    
    init(character: TamagotchiCharacter) {
        self.character = character
    }
    
    func transform(input: Input) -> Output {
        let selectCharacter = input.select
            .withUnretained(self)
            .map { owner, _ in
                return owner.character
            }
        
        let output = Output(
            selectButtonTitle: Observable.just(UserDefaultsManager.shared.isOnboarding ? "시작하기" : "변경하기"),
            character: Observable.just(character),
            selectCharacter: selectCharacter,
            cancel: input.cancel.asObservable()
        )
        
        
        return output
    }
}
