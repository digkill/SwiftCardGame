import SpriteKit

enum CardType: Int {
    case wolf,
    bear,
    dragon
}

class Card : SKSpriteNode {
    var damage = 0
    let damageLabel :SKLabelNode
    
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
        
        damageLabel = SKLabelNode(fontNamed: "OpenSans-Bold")
        damageLabel.name = "damageLabel"
        damageLabel.fontSize = 12
        damageLabel.fontColor = SKColor(red: 0.47, green: 0.0, blue: 0.0, alpha: 1.0)
        damageLabel.text = "0"
        damageLabel.position = CGPoint(x: 25, y: 40)
        
        super.init(texture: frontTexture, color: UIColor.clear, size: frontTexture.size())
        
        addChild(damageLabel)
    }
}
