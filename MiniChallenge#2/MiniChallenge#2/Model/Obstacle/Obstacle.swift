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
    
    func setObstacleProperties(obstacle: SKSpriteNode) -> SKSpriteNode {
        obstacle.setScale(0.85)
        obstacle.zPosition = 5.0
        
        return obstacle
    }
    
}

