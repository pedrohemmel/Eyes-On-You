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
        
        //Phisics properties
        character.physicsBody = SKPhysicsBody(rectangleOf: character.frame.size)
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.isDynamic = true
        
        return character
    }
    
    func characterToFly(character: SKSpriteNode) -> SKSpriteNode {
        let character = SKSpriteNode()
        
        
        
        return character
    }
}
