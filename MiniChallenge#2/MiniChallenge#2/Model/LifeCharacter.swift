//
//  LifeCharacter.swift
//  MiniChallenge#2
//
//  Created by Higor Crisostomo on 22/11/22.
//
import SpriteKit


class LifeCharacter: SKNode {
        
    var lifeCharacter1: SKSpriteNode
    var lifeCharacter2: SKSpriteNode
    var lifeCharacter3: SKSpriteNode
    
    override init() {
        self.lifeCharacter1 = SKSpriteNode(imageNamed: "skull")
        self.lifeCharacter2 = SKSpriteNode(imageNamed: "skull")
        self.lifeCharacter3 = SKSpriteNode(imageNamed: "skull")
        
        super.init()
        setupCharacter()
    }
    
    required init? (coder aDecoder: NSCoder) {
        self.lifeCharacter1 = SKSpriteNode(color: .white, size: .init(width: 20, height: 20))
        self.lifeCharacter2 = SKSpriteNode(color: .white, size: .init(width: 20, height: 20))
        self.lifeCharacter3 = SKSpriteNode(color: .white, size: .init(width: 20, height: 20))
        
        super.init(coder: aDecoder)
        setupCharacter()
    }
        
    
    //Funcão qua configura a imagem na cena
    private func setupCharacter() {
        addChild(lifeCharacter1)
        addChild(lifeCharacter2)
        addChild(lifeCharacter3)
        
        
        lifeCharacter1.zPosition += 5
        lifeCharacter1.anchorPoint = .init(x: 1.0, y: 0.5)
        lifeCharacter1.position.x = -(lifeCharacter1.size.width/2)
        
        lifeCharacter2.zPosition += 5
        lifeCharacter2.anchorPoint = .init(x: 2.0, y: 0.5)
        lifeCharacter2.position.x = -(lifeCharacter2.size.width/2)
        
        lifeCharacter3.zPosition += 5
        lifeCharacter3.anchorPoint = .init(x: 3.0, y: 0.5)
        lifeCharacter3.position.x = -(lifeCharacter3.size.width/2)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
//    var life: Int = 3
//    var lifeNodes: [SKSpriteNode] = []
//    var cameraNode = SKCameraNode()
//    var size = 100
//
//    var playableRect: CGRect {
//        let ratio: CGFloat
//        switch UIScreen.main.nativeBounds.height {
//        case 2688, 1792, 2436:
//            ratio = 2.26
//        default:
//            ratio = 16/9
//        }
//
//        let playableHeight = 100 / ratio
//        let playableMargin = (100 - playableHeight) / 2.0
//
//        return CGRect(x: 0.0, y: playableMargin, width: 100, height: playableHeight)
//    }
//
//
//
//    func setupLife() {
//        let life1 = SKSpriteNode(imageNamed: "face.smiling")
//        let life2 = SKSpriteNode(imageNamed: "face.smiling")
//        let life3 = SKSpriteNode(imageNamed: "face.smiling")
//
//        lifeNodes.append(life1)
//        lifeNodes.append(life2)
//        lifeNodes.append(life3)
//
//        setupLifePosition(life1, i: 1.0, j: 0.0)
//        setupLifePosition(life2, i: 2.0, j: 8.0)
//        setupLifePosition(life3, i: 3.0, j: 16.0)
//    }
//
//
//    func setupLifePosition(_ node: SKSpriteNode, i: CGFloat, j: CGFloat) {
//        let width = playableRect.width
//        let heigth = playableRect.width
//
//        node.setScale(0.5)
//        node.zPosition = 500.0
//        node.position = CGPoint(x: -width/2.0 + node.frame.width*i + j - 15.0,
//                                y: heigth/2.0 - node.frame.height/2.0)
//        cameraNode.addChild(node)
//    }

}


