//
//  ChangeMasterNameViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/24/25.
//

import RxSwift
import RxCocoa

final class ChangeMasterNameViewModel: ViewModel {
    struct Input {
        let nameInput: ControlProperty<String>
        let saveButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let name: BehaviorRelay<String>
        let saveButtonValidation: Observable<Bool>
        let save: Driver<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let name = BehaviorRelay<String>(value: UserDefaultsManager.shared.masterName)
        
        let saveButtonValidation = input.nameInput
            .map { $0.count >= 2 && $0.count <= 8 && $0 != UserDefaultsManager.shared.masterName }
        
        input.nameInput.changed
            .bind(to: name)
            .disposed(by: disposeBag)
        
        input.saveButtonTapped
            .withLatestFrom(name)
            .bind { name in
                UserDefaultsManager.shared.masterName = name
            }
            .disposed(by: disposeBag)
        
        let output = Output(
            name: name,
            saveButtonValidation: saveButtonValidation,
            save: input.saveButtonTapped.asDriver()
        )
        
        return output
    }
}
