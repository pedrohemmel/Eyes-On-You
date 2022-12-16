//
//  Tutorial.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 15/12/22.
//

import Foundation
import SpriteKit

class Tutorial: SKScene {
    
    var image: SKSpriteNode = SKSpriteNode(imageNamed: "tutorial_tela1")
    

    //MARK: - Systems

    override func sceneDidLoad() {
        setupNodes()
    }
}

extension Tutorial {
    
    func setupNodes(){
        //setupBG()
        closeButton()
        setupImage()
        nextImage()
        
    }

    func closeButton(){
        let closeButton = CustomizedButton(imageName: "close", buttonAction: {
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
        })
        
        closeButton.setScale(0.3)
        closeButton.zPosition = 10.0
        closeButton.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        addChild(closeButton)
    }
    
    
    func setupImage() {
        self.image.zPosition = 5.0
        self.image.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(self.image)
    }
    
    func nextImage() {
        var numImg = 1
        let nextButton = CustomizedButton(imageName: "right") {
            
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            numImg += 1
            numImg <= 4 ?  self.image.texture = SKTexture(imageNamed: "tutorial_tela\(numImg)") : self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
        }
        
        nextButton.setScale(0.4)
        nextButton.zPosition = 10.0
        nextButton.position = CGPoint(x: frame.maxX - 30, y: frame.midY - 100)
        addChild(nextButton)
    }
}

