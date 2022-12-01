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
    
    public var characterLife: [SKSpriteNode] = []
    
    //Initializing class and applying an init of SKSpriteNode to the characterView
    init() { 
        self.characterView = SKSpriteNode()
        
        characterLife = [SKSpriteNode(imageNamed: "morte"), SKSpriteNode(imageNamed: "morte"), SKSpriteNode(imageNamed: "morte")]
    }
    
    //Setting SpriteKit properties to a var and returning it
    func characterToApplyProperties(character: SKSpriteNode, view: SKScene) -> SKSpriteNode {
        
        //Properties of size and position
//        character.size = CGSize(width: 100, height: 100)
        character.setScale(0.10)
        character.position = CGPoint(x: 100, y: 100)
        character.zPosition = 5
        
        //Physics properties
        character.physicsBody = SKPhysicsBody(rectangleOf: character.frame.size)
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.isDynamic = true
        character.physicsBody?.allowsRotation = false
        
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
        character.physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.obstacle
        character.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        
        return character
    }
    
    func characterLifeToSetProperties(characterLife: [SKSpriteNode], view: SKScene) -> [SKSpriteNode] {
        var cont: CGFloat = 30
        
        var characterLifeAux = [SKSpriteNode]()
        
        for life in characterLife {
            //Properties of size and position
            life.size = CGSize(width: 20, height: 20)
            life.position = CGPoint(x: view.frame.width - cont, y: view.frame.height - 20.0)
            life.zPosition = 7
            
            cont = cont + 30
            
            characterLifeAux.append(life)
        }
        
        return characterLifeAux
    }
}
