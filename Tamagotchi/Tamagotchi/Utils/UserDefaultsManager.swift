//
//  UserDefaultsManager.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

import Foundation

final class UserDefaultsManager {
    private enum UserDefaultsKey: String, CaseIterable {
        case isOnboardingDone
        case character
        case masterName
    }

    static let shared = UserDefaultsManager()
    
    @UserDefault(
        key: UserDefaultsKey.isOnboardingDone.rawValue,
        defaultValue: true
    )
    var isOnboarding: Bool
    @UserDefault(
        key: UserDefaultsKey.character.rawValue,
        defaultValue: CharacterInformation(
            character: TamagotchiCharacter.notReady,
            water: 0,
            food: 0
        )
    )
    var character: CharacterInformation
    @UserDefault(
        key: UserDefaultsKey.masterName.rawValue,
        defaultValue: "대장"
    )
    var masterName: String
    
    func resetUserData() {
        UserDefaultsKey.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
