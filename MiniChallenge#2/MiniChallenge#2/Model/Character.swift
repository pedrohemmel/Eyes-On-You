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
        
        characterLife = [SKSpriteNode(imageNamed: "caveira_vermelha"), SKSpriteNode(imageNamed: "caveira_vermelha"), SKSpriteNode(imageNamed: "caveira_vermelha")]
    }
    
    //Setting SpriteKit properties to a var and returning it
    func characterToApplyProperties(character: SKSpriteNode, view: SKScene, zPosition: CGFloat? = nil) -> SKSpriteNode {
        
        character.setScale(0.13)
        character.position = CGPoint(x: 250, y: 100)
        if zPosition != nil {
            character.zPosition = zPosition!
        } else {
            character.zPosition = 4
        }
        
        
        //Physics properties
        character.physicsBody = SKPhysicsBody(texture: character.texture!, size: character.size)
//        character.physicsBody = SKPhysicsBody(rectangleOf: character.size)
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.isDynamic = true
        character.physicsBody?.allowsRotation = false
        
        return character
    }
    
    //Setting impulse to the object, this impulse makes the objetc fly
    func characterToFly(character: SKSpriteNode) -> SKSpriteNode {
        
        character.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        character.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        
        return character
    }
    
    //Setting properties of collision and contact
    func characterToCollide(character: SKSpriteNode) -> SKSpriteNode {
        character.physicsBody?.categoryBitMask = PhysicsCategory.character
        character.physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.ceiling
        character.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        
        return character
    }
    
    //Criando e posicionando os icones de vida
    func characterLifeToSetProperties(characterLife: [SKSpriteNode], view: SKScene) -> [SKSpriteNode] {
        var cont: CGFloat = 40
        
        var characterLifeAux = [SKSpriteNode]()
        
        for life in characterLife {
            //Properties of size and position
            life.size = CGSize(width: 50, height: 50)
            life.position = CGPoint(x: cont, y: view.frame.height - 30.0)
            life.zPosition = 2
            
            cont = cont + 35
            
            characterLifeAux.append(life)
        }
        
        return characterLifeAux
    }
    
    func characterToRemoveLifesFromParent() -> Void {
        for life in self.characterLife {
            life.removeFromParent()
        }
    }
}
