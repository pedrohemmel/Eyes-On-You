//
//  Score.swift
//  MiniChallenge#2
//
//  Created by Marcelo Araujo on 18/11/22.
//

import Foundation
import SpriteKit


class Score: SKNode {
    
    public static var shared = Score()
    
//    var scoreLabel: SKLabelNode = SKLabelNode()
    
    let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    var renderTime: TimeInterval = 0.0
    var changeTime: TimeInterval = 1
    
    public var gameScore: Int = 0
    
    public var highScore: Int {
        get {
          return UserDefaults.standard.integer(forKey: "highscore")
        }
        
        
        set {
            UserDefaults.standard.set(newValue, forKey: "highscore")
        }
    }
    
    public func addScore() {
        self.gameScore += 1
    }
    
    public func trySaveHighScore() {
        if self.highScore < self.gameScore {
            self.highScore = self.gameScore
        }
    }
    
    
    
//    override init() {
//        super.init()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
