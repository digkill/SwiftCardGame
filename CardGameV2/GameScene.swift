import SpriteKit

enum CardLevel :CGFloat {
  case board = 10
  case moving = 100
  case enlarged = 200
}

class GameScene: SKScene {

  override func didMove(to view: SKView) {
    let bg = SKSpriteNode(imageNamed: "bg_blank")
    bg.anchorPoint = CGPoint.zero
    bg.position = CGPoint.zero
    addChild(bg)
    
    let wolf = Card(cardType: .wolf)
    wolf.position = CGPoint(x: 100,y: 200)
    addChild(wolf)
    
    let bear = Card(cardType: .bear)
    bear.position = CGPoint(x: 300, y: 200)
    addChild(bear)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let location = touch.location(in: self)
      if let card = atPoint(location) as? Card {
        card.zPosition = CardLevel.moving.rawValue
        if touch.tapCount > 1 {
          card.enlarge()
          return
        }
        
        if card.enlarged { return }
        
//        let wiggleIn = SKAction.scaleX(to: 1.0, duration: 0.2)
//        let wiggleOut = SKAction.scaleX(to: 1.2, duration: 0.2)
//        let wiggle = SKAction.sequence([wiggleIn, wiggleOut])
//
//        card.run(SKAction.repeatForever(wiggle), withKey: "wiggle")

        let rotR = SKAction.rotate(byAngle: 0.15, duration: 0.2)
        let rotL = SKAction.rotate(byAngle: -0.15, duration: 0.2)
        let cycle = SKAction.sequence([rotR, rotL, rotL, rotR])
        let wiggle = SKAction.repeatForever(cycle)
        card.run(wiggle, withKey: "wiggle")
        
        card.removeAction(forKey: "drop")
        card.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let location = touch.location(in: self)
      if let card = atPoint(location) as? Card {
        if card.enlarged { return }
        card.position = location
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let location = touch.location(in: self)
      if let card = atPoint(location) as? Card {
        if card.enlarged { return }
        
        card.zPosition = CardLevel.board.rawValue
        
        card.removeAction(forKey: "wiggle")
        card.run(SKAction.rotate(toAngle: 0, duration: 0.2), withKey:"rotate")
        
        card.removeAction(forKey: "pickup")
        card.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
        
        card.removeFromParent()
        addChild(card)
      }
    }
  }
  
}
