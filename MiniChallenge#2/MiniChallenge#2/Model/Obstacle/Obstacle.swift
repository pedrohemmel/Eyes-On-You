//
//  Obstacle.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 16/11/22.
//

import SpriteKit
import GameplayKit

class Obstacle {
    
    public var obstacle: SKSpriteNode
    private var day: Bool
    
    init(day: Bool, obstacle: SKSpriteNode) {
        self.day = day
        self.obstacle = obstacle
        
        self.obstacle = obstacleToSetPhysics(obstacle: self.obstacle)
    }
    
    func obstacleToSetSize(obstacle: SKSpriteNode, obSize: CGSize, obZPosition: CGFloat) -> SKSpriteNode {
        obstacle.zPosition = obZPosition
        obstacle.size = obSize
        return obstacle
    }
    
    func obstacleToSetPhysics(obstacle: SKSpriteNode) -> SKSpriteNode {
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.frame.size)
        obstacle.physicsBody?.affectedByGravity = true
        obstacle.physicsBody?.isDynamic = true
        
        return obstacle
    }
    
    func obstacleToCollide(obstacle: SKSpriteNode) -> SKSpriteNode {
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.character
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.character
        
        return obstacle
    }
    
}

