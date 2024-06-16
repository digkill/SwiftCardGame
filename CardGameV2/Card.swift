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
    
    var faceUp = true
    
    var enlarged = false
    var savedPosition = CGPoint.zero
    
    let largeTextureFilename :String
    var largeTexture :SKTexture?

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType: CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "card_back")
        
        switch cardType {
        case .wolf:
          frontTexture = SKTexture(imageNamed: "card_creature_wolf")
          largeTextureFilename = "card_creature_wolf_large"
        case .bear:
          frontTexture = SKTexture(imageNamed: "card_creature_bear")
          largeTextureFilename = "card_creature_bear_large"
        case .dragon:
          frontTexture = SKTexture(imageNamed: "card_creature_dragon")
            largeTextureFilename = "card_creature_dragon_large"
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
    
    func flip() {
      let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.4)
      let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.4)
      
      setScale(1.0)
      
      if faceUp {
        run(firstHalfFlip, completion: {
          self.texture = self.backTexture
          self.damageLabel.isHidden = true
          
          self.run(secondHalfFlip)
        })
      } else {
        run(firstHalfFlip, completion: {
          self.texture = self.frontTexture
          self.damageLabel.isHidden = false
          
          self.run(secondHalfFlip)
        })
      }
      faceUp = !faceUp
    }
    
    func enlarge() {
      if enlarged {
        let slide = SKAction.move(to: savedPosition, duration:0.3)
        let scaleDown = SKAction.scale(to: 1.0, duration:0.3)
        run(SKAction.group([slide, scaleDown]), completion: {
          self.enlarged = false
          self.zPosition = CardLevel.board.rawValue
        })
      } else {
        enlarged = true
        savedPosition = position
        
        if largeTexture != nil {
          texture = largeTexture
        } else {
          largeTexture = SKTexture(imageNamed: largeTextureFilename)
          texture = largeTexture
        }
        
        zPosition = CardLevel.enlarged.rawValue
        
        if let parent = parent {
          removeAllActions()
          zRotation = 0
          let newPosition = CGPoint(x: parent.frame.midX, y: parent.frame.midY)
          let slide = SKAction.move(to: newPosition, duration:0.3)
          let scaleUp = SKAction.scale(to: 5.0, duration:0.3)
          run(SKAction.group([slide, scaleUp]))
        }
      }
    }
}
