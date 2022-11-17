//
//  GhostObstacle.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 17/11/22.
//

import Foundation
import SpriteKit

class GhostObstacle: Obstacle {
    init(){
        super.init(day: false, obstacle: SKSpriteNode(imageNamed: ""))
    }
    
    override func obstacleToSetProperties(obstacle: SKSpriteNode) -> SKSpriteNode {
        
        obstacle.zPosition = 5
        //temporario
        obstacle.size = CGSize(width: 100, height: 100)
        obstacle.position = CGPoint(x: 0, y: 0)

        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.frame.size)
        obstacle.physicsBody?.affectedByGravity = true
        obstacle.physicsBody?.isDynamic = true
        
        return obstacle
    }
}
