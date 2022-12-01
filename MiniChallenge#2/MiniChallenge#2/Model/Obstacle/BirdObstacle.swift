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
        
        self.obstacleView = obstacleToSetSize(obstacle: self.obstacleView, obZPosition: 4)
//        self.obstacleView.setScale(0.5)
    }
}
