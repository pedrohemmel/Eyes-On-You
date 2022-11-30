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
        super.init(day: true, obstacle: {
            let animatedObject = AnimatedObject("corvo")
            animatedObject.setScale(0.13)
            return animatedObject
        }())
        
        self.obstacleView = obstacleToSetSize(obstacle: self.obstacleView, obSize: CGSize(width: 100, height: 100), obZPosition: 8)
    }
}
