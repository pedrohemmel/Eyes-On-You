//
//  GameScene.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let character = Character.character
    private let obstacle = BirdObstacle()
    private let ground = SKSpriteNode(imageNamed: "")
    
    override func didMove(to view: SKView) {
        character.characterView = SKSpriteNode(imageNamed: "examploOfCharacter")
        character.characterView = character.characterToApplyProperties(character: character.characterView, view: self)
        character.characterView = character.characterToCollide(character: character.characterView)
        
        obstacle.obstacleView = obstacle.obstacleToCollide(obstacle: obstacle.obstacleView)
        obstacle.obstacleView.position = CGPoint(x: self.frame.width / 2 - obstacle.obstacleView.frame.width, y: self.frame.height / 2)
        
        ground.size = CGSize(width: self.frame.width, height: 100)
        ground.position = CGPoint(x: 0, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        ground.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        
        self.addChild(character.characterView)
        self.addChild(obstacle.obstacleView)
        self.addChild(ground)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if
            firstBody.categoryBitMask == PhysicsCategory.character && secondBody.categoryBitMask == PhysicsCategory.obstacle
                ||
                firstBody.categoryBitMask == PhysicsCategory.obstacle && secondBody.categoryBitMask == PhysicsCategory.character {
            print("\n\n\npega aqui\n\n\n\n")
        }
                
    }
    
    func touchDown(atPoint pos : CGPoint) {
        character.characterView.position = pos
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
