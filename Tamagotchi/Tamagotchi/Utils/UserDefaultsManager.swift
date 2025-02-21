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
    }

    static let shared = UserDefaultsManager()
    
    @UserDefault(
        key: UserDefaultsKey.isOnboardingDone.rawValue,
        defaultValue: true
    )
    var isOnboarding: Bool
    
    func resetUserData() {
        UserDefaultsKey.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
