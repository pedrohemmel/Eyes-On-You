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
        super.init(day: false, obstacle: SKSpriteNode(imageNamed: ""))
        
        self.obstacleView = obstacleToSetSize(obstacle: self.obstacleView, obZPosition: 4)
    }
}
