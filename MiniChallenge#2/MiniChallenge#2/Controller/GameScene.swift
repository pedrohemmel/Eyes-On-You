//
//  GameScene.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let character = Character.character
    private let obstacle = BirdObstacle()
    private var ground = SKSpriteNode(imageNamed: "")
    
    override func didMove(to view: SKView) {
        
        //Relating the SKPhysicsContactDelegate to the self class
        self.physicsWorld.contactDelegate = self
        
        //Creating and calling the functions that make structure of the character
        character.characterView = SKSpriteNode(imageNamed: "examploOfCharacter")
        character.characterView = character.characterToApplyProperties(character: character.characterView, view: self)
        character.characterView = character.characterToCollide(character: character.characterView)
        
        //Creating and calling the functions that make structure of the obstacle
        obstacle.obstacleView = obstacle.obstacleToCollide(obstacle: obstacle.obstacleView)
        obstacle.obstacleView.position = CGPoint(x: self.frame.width / 2 - obstacle.obstacleView.frame.width, y: self.frame.height / 2)
        
        //Creating the ground object
        self.ground = groundToCreate(ground: self.ground)
        
        //Adding the children to the self class
        self.addChild(character.characterView)
        self.addChild(obstacle.obstacleView)
        self.addChild(ground)
    }
    
    //Function that detect the contact of the bodies
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        //Conditional structure that verify the contact bodies
        if firstBody.categoryBitMask == PhysicsCategory.character && secondBody.categoryBitMask == PhysicsCategory.obstacle || firstBody.categoryBitMask == PhysicsCategory.obstacle && secondBody.categoryBitMask == PhysicsCategory.character {
            self.character.characterView = character.characterToFly(character: self.character.characterView)
        }
    }
    
    //MARK: - Creating objects of the main scene
    func groundToCreate(ground: SKSpriteNode) -> SKSpriteNode {
        ground.size = CGSize(width: self.frame.width, height: 100)
        ground.position = CGPoint(x: 0, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        ground.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        
        return ground
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.character.characterView = self.character.characterToFly(character: self.character.characterView)
        
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
