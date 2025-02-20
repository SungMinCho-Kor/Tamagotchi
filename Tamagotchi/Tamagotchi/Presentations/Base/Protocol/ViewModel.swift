//
//  ViewModel.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
