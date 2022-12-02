//
//  SKButtonNode.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 30/11/22.
//

import Foundation
import SpriteKit

class SKButtonNode: SKNode {
    var image: SKSpriteNode?
    var label: SKLabelNode?
    var action: (() -> Void)?
    
    init(image: SKSpriteNode, label: SKLabelNode, action: @escaping() -> Void){
        self.image = image
        self.label = label
        self.action = action
        super.init()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
