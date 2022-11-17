//
//  Character.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import Foundation
import SpriteKit

public class Character {
    
    //Creating a static var to the manegement of the class
    static let character = Character()
    
    public var characterView: SKSpriteNode
    
    //Initializing class and applying an init of SKSpriteNode to the characterView
    init() { 
        self.characterView = SKSpriteNode()
    }
    
    //Setting SpriteKit properties to a var and returning it
    func characterToApplyProperties(character: SKSpriteNode) -> SKSpriteNode {
        
        //Properties of size and position
        character.size = CGSize(width: 100, height: 100)
        character.position = CGPoint(x: 0 - character.frame.width, y: 0)
        character.zPosition = 5
        
        //Physics properties
        character.physicsBody = SKPhysicsBody(rectangleOf: character.frame.size)
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.isDynamic = true
        
        return character
    }
    
    //Setting impulse to the object, this impulse makes the objetc fly
    func characterToFly(character: SKSpriteNode) -> SKSpriteNode {
        
        character.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        character.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 250))
        
        return character
    }
    
    //Setting properties of collision and contact
    func characterToCollide(character: SKSpriteNode) -> SKSpriteNode {
        character.physicsBody?.categoryBitMask = PhysicsCategory.character
        character.physicsBody?.contactTestBitMask = PhysicsCategory.ground | PhysicsCategory.obstacle
        character.physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.obstacle
        
        return character
    }
}
