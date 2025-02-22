//
//  CharacterInformation.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

struct CharacterInformation: Codable {
    var character: TamagotchiCharacter
    var level: Int {
        Int(Double(food) / 5 + (Double(water) / 2))
    }
    var water: Int
    var food: Int
    var imageName: String {
        if let number = character.number {
            return "\(number)-\(level + 1)"
        } else {
            return "noImage"
        }
    }
}
