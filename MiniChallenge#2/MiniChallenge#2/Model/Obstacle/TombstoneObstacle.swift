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
        super.init(day: true , obstacle: SKSpriteNode(imageNamed: "lapide1"))
        
        self.obstacleView = obstacleToSetSize(obstacle: self.obstacleView, obSize: self.obstacleView.size, obZPosition: 8)
    }
}
