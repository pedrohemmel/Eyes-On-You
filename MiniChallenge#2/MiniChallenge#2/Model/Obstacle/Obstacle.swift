//
//  Obstacle.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 16/11/22.
//

import SpriteKit
import GameplayKit

class Obstacle {
    
    public var obstacleView: SKSpriteNode
    public var actionObstacle: SKAction = SKAction.moveBy(x: 0, y: 0, duration: 0.004)
    private var day: Bool
    
    init(day: Bool) {
        self.day = day
        self.obstacleView = SKSpriteNode()
    }
    
    func obstacleToSetSize(obstacle: SKSpriteNode) -> SKSpriteNode {
        obstacle.zPosition = 2
        return obstacle
    }
    
    func obstacleToSetPhysics(obstacle: SKSpriteNode) -> SKSpriteNode {
        
        obstacle.physicsBody = SKPhysicsBody(texture: obstacle.texture!, size: obstacle.size)
//        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.affectedByGravity = true
        obstacle.physicsBody?.isDynamic = true
        
        obstacle.physicsBody?.mass = 10
        
        return obstacle
    }
    
    func obstacleToCollide(obstacle: SKSpriteNode) -> SKSpriteNode {
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.character
        
        return obstacle
    }
    
}

