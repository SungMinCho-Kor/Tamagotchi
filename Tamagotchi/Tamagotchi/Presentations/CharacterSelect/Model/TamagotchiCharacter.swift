//
//  TamagotchiCharacter.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/20/25.
//

struct TamagotchiCharacter: Equatable, Codable {
    let name: String
    let respresentativeImageName: String
    let description: String
    let number: Int?
    
    init(
        name: String,
        respresentativeImageName: String,
        description: String,
        number: Int? = nil
    ) {
        self.name = name
        self.respresentativeImageName = respresentativeImageName
        self.description = description
        self.number = number
    }
    
    static let notReady = TamagotchiCharacter(
        name: "준비중이에요",
        respresentativeImageName: "noImage",
        description: "준비중이에요"
    )
}

struct TamagotchiCharacters {
    // 30개
    let list: [TamagotchiCharacter] = [
        TamagotchiCharacter(
            name: "따끔따끔 다마고치",
            respresentativeImageName: "1-6",
            description: """
저는 선인장 다마고치 입니다. 키는 2cm
몸무게는 150g이에요.
성격은 소심하지만 마음은 따뜻해요.
열심히 잘 먹고 잘 클 자신은 있답니다.
반가워요 주인님!!!
""",
            number: 1
        ),
        TamagotchiCharacter(
            name: "방실방실 다마고치",
            respresentativeImageName: "2-6",
            description: """
저는 방실방실 다마고치 입니다. 키는 100km
몸무게는 150톤이에요.
성격은 화끈하고 날라다닙니당~!
열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!
""",
            number: 2
        ),
        TamagotchiCharacter(
            name: "반짝반짝 다마고치",
            respresentativeImageName: "3-6",
            description: """
저는 반짝반짝 다마고치 입니다. 키는 50km
몸무게는 100톤이에요.
성격은 밝고 튀는 성격에 날라다녀요.
열심히 잘 먹고 잘 클 자신은 있습니당ㅎ
반짝반짝~~**
""",
            number: 3
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
