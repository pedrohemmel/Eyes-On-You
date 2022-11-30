//
//  HandObstacle.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 17/11/22.
//

import Foundation
import SpriteKit

class HandObstacle: Obstacle {
    init(){
        super.init(day: false, obstacle: {
            let animatedObject = AnimatedObject("maos")
            animatedObject.setScale(0.13)
            return animatedObject
        }())
        
        self.obstacleView = obstacleToSetSize(obstacle: self.obstacleView, obSize: self.obstacleView.size, obZPosition: 8)
    }
}
