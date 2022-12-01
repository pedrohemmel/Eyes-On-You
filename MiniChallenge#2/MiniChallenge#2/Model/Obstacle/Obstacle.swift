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
    private var day: Bool
    
    init(day: Bool, obstacle: SKSpriteNode) {
        self.day = day
        self.obstacleView = obstacle
        
        self.obstacleView = obstacleToSetPhysics(obstacle: self.obstacleView)
    }
    
    func obstacleToSetSize(obstacle: SKSpriteNode, obZPosition: CGFloat) -> SKSpriteNode {
        obstacle.zPosition = obZPosition
//        obstacle.setScale(0.3)
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
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.ground
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.character | PhysicsCategory.ground
        
        return obstacle
    }
    
}

