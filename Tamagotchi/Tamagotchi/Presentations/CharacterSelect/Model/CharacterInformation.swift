//
//  CharacterInformation.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

struct CharacterInformation: Codable {
    var character: TamagotchiCharacter
    var level: Int {
        let calculatedLevel = Int(Double(food) / 5 + (Double(water) / 2)) / 10
        return calculatedLevel >= 10 ? 10 : calculatedLevel
    }
    var water: Int
    var food: Int
    var imageName: String {
        if let number = character.number {
            if level < 9 {
                return "\(number)-\(level + 1)"
            } else {
                return "\(number)-9"
            }
        } else {
            return "noImage"
        }
    }
}
