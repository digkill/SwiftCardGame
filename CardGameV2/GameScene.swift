import SpriteKit

class GameScene: SKScene {

  override func didMove(to view: SKView) {
    let bg = SKSpriteNode(imageNamed: "bg_blank")
    bg.anchorPoint = CGPoint.zero
    bg.position = CGPoint.zero
    addChild(bg)
    
    let wolf = Card(cardType: .wolf)
    wolf.position = CGPoint(x: 100, y: 200)
    addChild(wolf)

    let bear = Card(cardType: .bear)
    bear.position = CGPoint(x: 300, y: 200)
    addChild(bear)
    
    }

}
