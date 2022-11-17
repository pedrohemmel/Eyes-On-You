//
//  Obstacle.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 16/11/22.
//

import SpriteKit
import GameplayKit

class Obstacle {
    
    private var obstacle: SKSpriteNode
    private var day: Bool
    
    init(day: Bool, obstacle: SKSpriteNode) {
        self.day = day
        self.obstacle = obstacle
    }
    
    func obstacleToSetProperties(obstacle: SKSpriteNode) -> SKSpriteNode {
        return obstacle
    }
    
    func obstacleToCollide(obstacle: SKSpriteNode) -> SKSpriteNode {
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.character
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.character
        
        return obstacle
    }
    
}

