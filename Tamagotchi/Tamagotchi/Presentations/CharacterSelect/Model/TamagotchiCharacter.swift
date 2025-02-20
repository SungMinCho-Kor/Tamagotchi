//
//  TamagotchiCharacter.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

struct TamagotchiCharacter {
    let name: String
    let imageName: String
    let description: String
    
    
    static let notReady = TamagotchiCharacter(
        name: "준비중이에요",
        imageName: "noImage",
        description: "준비중이에요"
    )
}

struct TamagotchiCharacters {
    // 30개
    let list: [TamagotchiCharacter] = [
        TamagotchiCharacter(
            name: "따끔따끔 다마고치",
            imageName: "1-6",
            description: """
저는 선인장 다마고치 입니다. 키는 2cm
몸무게는 150g이에요.
성격은 소심하지만 마음은 따뜻해요.
열심히 잘 먹고 잘 클 자신은 있답니다.
반가워요 주인님!!!
"""
        ),
        TamagotchiCharacter(
            name: "방실방실 다마고치",
            imageName: "2-6",
            description: """
저는 선인장 다마고치 입니다. 키는 2cm
몸무게는 150g이에요.
성격은 소심하지만 마음은 따뜻해요.
열심히 잘 먹고 잘 클 자신은 있답니다.
반가워요 주인님!!!
"""
        ),
        TamagotchiCharacter(
            name: "반짝반짝 다마고치",
            imageName: "3-6",
            description: """
저는 선인장 다마고치 입니다. 키는 2cm
몸무게는 150g이에요.
성격은 소심하지만 마음은 따뜻해요.
열심히 잘 먹고 잘 클 자신은 있답니다.
반가워요 주인님!!!
"""
        ),
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady,
        TamagotchiCharacter.notReady
    ]
}
