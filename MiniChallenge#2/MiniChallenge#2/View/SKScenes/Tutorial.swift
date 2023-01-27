//
//  Tutorial.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 15/12/22.
//

import Foundation
import SpriteKit

class Tutorial: SKScene {
    
    //MARK: - Global variables
    var numImg = 1 {
        didSet {
            if numImg >= 1 && numImg <= 4 {
                self.lblInstruction.text = arrayOfInstructions[self.numImg - 1].localizedLanguage()
            }
        }
    }
    let arrayOfInstructions: [String] =
    [
        "Toque na tela para voar e desviar dos obstáculos",
        "As caveiras representam suas vidas",
        "Você perde uma vida ao tropeçar em um obstáculo ou ser atingido por algo",
        "Você pode pausar e retomar o jogo quando quiser!"
    ]
    
    //MARK: - Components
    lazy var image: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "tutorial_tela1")
        image.zPosition = 2.0
        image.position = CGPoint(x: frame.midX, y: frame.midY)
        image.size = self.size
        return image
    }()
    
    lazy var closeButton: CustomizedButton = {
        let closeButton = CustomizedButton(imageName: "back", lblText: nil, buttonAction: {
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
        })
        closeButton.setScale(0.25)
        closeButton.zPosition = 3
        closeButton.position = CGPoint(x: frame.width / 12, y: frame.height - (frame.height / 7))
        return closeButton
    }()
    
    lazy var lblInstruction: SKLabelNode = {
        let lblInstruction = SKLabelNode(fontNamed: "AvenirNext-Bold")
        lblInstruction.fontSize = 20
        lblInstruction.horizontalAlignmentMode = .center
        lblInstruction.text = arrayOfInstructions[self.numImg - 1].localizedLanguage()
        lblInstruction.preferredMaxLayoutWidth = frame.width * 0.78
        lblInstruction.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblInstruction.numberOfLines = 0
        lblInstruction.fontColor = .white
        lblInstruction.position = CGPoint(x: frame.midX, y: frame.midY)
        lblInstruction.zPosition = 3
        return lblInstruction
    }()
    
    lazy var previousButton: CustomizedButton = {
        let previousButton = CustomizedButton(imageName: "left", lblText: nil) {
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            self.previousScreenOfTutorial() {
                self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
            }
        }
        previousButton.setScale(0.8)
        previousButton.zPosition = 3
        previousButton.position = CGPoint(x: self.frame.width / 4.75, y: 100)
        return previousButton
    }()
    lazy var nextButton = {
        let nextButton = CustomizedButton(imageName: "right", lblText: nil) {
            let screenInfo = Info(size: self.frame.size)
            screenInfo.scaleMode = .aspectFill
            self.nextScreenOfTutorial() {
                self.view?.presentScene(screenInfo, transition: SKTransition.fade(with: .black, duration: 1))
            }
        }
        nextButton.setScale(0.8)
        nextButton.zPosition = 3
        nextButton.position = CGPoint(x: self.frame.width / 1.25, y: 100)
        return nextButton
    }()

    //MARK: - Initializers
    override func sceneDidLoad() {
        self.setupNodes()
    }
}

//MARK: - Functions here
extension Tutorial {
    private func setupNodes(){
        self.addChild(self.closeButton)
        self.addChild(self.image)
        self.addChild(self.lblInstruction)
        self.addChild(self.nextButton)
        self.addChild(self.previousButton)
    }
    
    private func previousScreenOfTutorial(presentView: @escaping () -> Void) -> Void {
        var num = self.numImg
        num -= 1
        if num >= 1 {
            self.numImg -= 1
            self.image.texture = SKTexture(imageNamed: "tutorial_tela\(self.numImg)")
        } else {
            presentView()
        }
    }
    private func nextScreenOfTutorial(presentView: @escaping () -> Void) {
        var num = self.numImg
        num += 1
        if num <= 4 {
            self.numImg += 1
            self.image.texture = SKTexture(imageNamed: "tutorial_tela\(self.numImg)")
        } else {
            presentView()
        }
    }
}

