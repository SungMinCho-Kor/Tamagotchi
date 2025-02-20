//
//  ReuseIdentifiable.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

protocol ReuseIdentifiable { }

extension ReuseIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
