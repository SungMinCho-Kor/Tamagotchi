//
//  CellConfigurable.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

protocol CellConfigurable {
    associatedtype Content
    
    func configure(content: Content)
}
