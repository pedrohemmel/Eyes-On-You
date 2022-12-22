//
//  SavePrize.swift
//  MiniChallenge#2
//
//  Created by Marcelo Araujo on 19/12/22.
//

import Foundation
import SpriteKit

class SavePrize: SKNode{
    
    public static var shared = SavePrize()
    
    let coinPrize = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    public var saveCoin: Int {
        get {
          return UserDefaults.standard.integer(forKey: "coin")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "coin")
        }
    }
    
    public func addcCoin() {
        saveCoin += 1
    }
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
