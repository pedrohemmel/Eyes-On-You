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
        
        self.obstacleView = obstacleToSetSize(obstacle: self.obstacleView, obSize: CGSize(width: 100, height: 100), obZPosition: 4)
    }
}
