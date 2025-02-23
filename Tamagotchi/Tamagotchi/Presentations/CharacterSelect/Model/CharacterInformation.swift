//
//  CharacterInformation.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

struct CharacterInformation: Codable {
    var character: TamagotchiCharacter
    var level: Int {
        var calculatedLevel = Int(Double(food) / 5 + (Double(water) / 2)) / 10
        if calculatedLevel < 1 {
            calculatedLevel = 1
        } else if calculatedLevel > 10 {
            calculatedLevel = 10
        }
        return calculatedLevel
    }
    var water: Int
    var food: Int
    var imageName: String {
        if let number = character.number {
            if level < 9 {
                return "\(number)-\(level)"
            } else {
                return "\(number)-9"
            }
        } else {
            return "noImage"
        }
    }
}
