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
    var numImg = 1

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
        previousImage()
    }

    func closeButton(){
        let closeButton = CustomizedButton(imageName: "close", buttonAction: {
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
        })
        
        closeButton.setScale(0.6)
        closeButton.zPosition = 3
        closeButton.position = CGPoint(x: 42, y: self.frame.height - 35)
        addChild(closeButton)
    }
    
    
    func setupImage() {
        self.image.zPosition = 2.0
        self.image.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(self.image)
    }
    
    func previousImage() {
        
        
        
        let previousButton = CustomizedButton(imageName: "left") {
            
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            
            var num = self.numImg
            
            num -= 1
            if num >= 1 {
                self.numImg -= 1
                self.image.texture = SKTexture(imageNamed: "tutorial_tela\(self.numImg)")
            } else {
                self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
            }
        }
        
        previousButton.setScale(0.8)
        previousButton.zPosition = 3
        previousButton.position = CGPoint(x: self.frame.width / 4.75, y: 100)
        addChild(previousButton)
    }
    
    func nextImage() {
    
        let nextButton = CustomizedButton(imageName: "right") {
            
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            
            var num = self.numImg
            
            num += 1
            if num <= 4 {
                self.numImg += 1
                self.image.texture = SKTexture(imageNamed: "tutorial_tela\(self.numImg)")
            } else {
                self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
            }
            
            
        }
        
        nextButton.setScale(0.8)
        nextButton.zPosition = 3
        nextButton.position = CGPoint(x: self.frame.width / 1.25, y: 100)
        addChild(nextButton)
    }
}

