//
//  BirdObstacle.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 16/11/22.
//

import Foundation
import SpriteKit

class BirdObstacle: Obstacle {
    init() {
        super.init(day: true, obstacle: SKSpriteNode(imageNamed: ""))
        
        self.obstacle = obstacleToSetSize(obstacle: self.obstacle, obSize: self.obstacle.size, obZPosition: 4)
    }
}
