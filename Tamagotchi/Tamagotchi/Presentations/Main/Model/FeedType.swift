//
//  FeedType.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/23/25.
//

enum FeedType {
    case food
    case water
    
    var placeholder: String {
        switch self {
        case .food:
            return "밥주세용"
        case .water:
            return "물주세용"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .food:
            return "leaf.circle"
        case .water:
            return "drop.circle"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .food:
            return "밥먹기"
        case .water:
            return "물먹기"
        }
    }
    
    var amountWarning: String {
        switch self {
        case .food:
            return "밥은 1~100개 먹을 수 있어요!"
        case .water:
            return "물은 1~50개 먹을 수 있어요!"
        }
    }
}
