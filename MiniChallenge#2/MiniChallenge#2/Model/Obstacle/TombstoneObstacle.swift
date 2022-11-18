//
//  TombstoneObstacle.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 17/11/22.
//

import Foundation
import SpriteKit

class TombstoneObstacle: Obstacle {
    init() {
        super.init(day: true , obstacle: SKSpriteNode(imageNamed: ""))
        
        self.obstacle = obstacleToSetSize(obstacle: self.obstacle, obSize: self.obstacle.size, obZPosition: 4)
    }
}
