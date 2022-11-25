//
//  Score.swift
//  MiniChallenge#2
//
//  Created by Marcelo Araujo on 18/11/22.
//

import Foundation



class Score {
    
    public static var shared = Score()
    
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
}
