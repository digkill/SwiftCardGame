import SpriteKit

enum CardType: Int {
    case wolf,
    bear,
    dragon
}

class Card : SKSpriteNode {
    let cardType: CardType
    let frontTexture: SKTexture
    let backTexture: SKTexture
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType: CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "card_back")
        
        switch cardType {
        case .wolf:
            frontTexture = SKTexture(imageNamed: "card_creature_wolf")
        case .bear:
            frontTexture = SKTexture(imageNamed: "card_creature_bear")
        case .dragon:
            frontTexture = SKTexture(imageNamed: "card_creature_dragon")
        }
        
        super.init(texture: frontTexture, color: UIColor.clear, size: frontTexture.size())
    }
}
