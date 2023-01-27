//
//  Info.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 30/11/22.
//

import SpriteKit

class Info: SKScene {
    //MARK: - Components
    lazy var bgNode: SKSpriteNode = {
        let bgNode = SKSpriteNode(color: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1), size: CGSize(width: frame.width, height: frame.height))
        bgNode.zPosition = -1.0
        bgNode.anchorPoint = .zero
        bgNode.position = .zero
        return bgNode
    }()
    
    lazy var icon: SKSpriteNode = {
        let icon = SKSpriteNode(imageNamed: "i")
        icon.setScale(0.3)
        icon.zPosition = 10.0
        icon.position = CGPoint(x: frame.midX, y: frame.height - 50 )
        return icon
    }()
    
    lazy var back: CustomizedButton = {
        let back = CustomizedButton(imageName: "back", lblText: nil, buttonAction: {
            let telaGameScene = GameScene(size: self.frame.size)
            telaGameScene.scaleMode = .aspectFill
            self.view?.presentScene(telaGameScene, transition: SKTransition.fade(with: .black, duration: 1))
        })
        back.setScale(0.25)
        back.zPosition = 10.0
        back.position = CGPoint(x: frame.width / 12, y: frame.height - (frame.height / 7))
        return back
    }()
    
    lazy var tutorial: CustomizedButton = {
        let tutorial = CustomizedButton(imageName: "background_button", lblText: "Tutorial", buttonAction: {
            let tutorialScreen = Tutorial(size: self.frame.size)
            tutorialScreen.scaleMode = .aspectFill
            self.view?.presentScene(tutorialScreen, transition: SKTransition.fade(with: .black, duration: 1))
        })
        tutorial.zPosition = 10.0
        tutorial.position = CGPoint(x: size.width/2.8 - (frame.width * 0.01), y: frame.midY + (frame.height / 8))
        tutorial.setScale(0.45)
        return tutorial
    }()
    lazy var credits: CustomizedButton = {
        let credits = CustomizedButton(imageName: "background_button", lblText: "Créditos", buttonAction: {
            let screenChoosed = ScreenInfoChoosed(tela: 2, size: self.frame.size)
            screenChoosed.scaleMode = .aspectFill
            self.view?.presentScene(screenChoosed, transition: SKTransition.fade(with: .black, duration: 1))
        })
        credits.zPosition = 10.0
        credits.position = CGPoint(x: size.width/1.55 + (frame.width * 0.01), y: frame.midY + (frame.height / 8))
        credits.setScale(0.45)
        return credits
    }()
    lazy var politics: CustomizedButton = {
        let politics = CustomizedButton(imageName: "background_button", lblText: "Políticas de privacidade", buttonAction: {
            let screenChoosed = ScreenInfoChoosed(tela: 3, size: self.frame.size)
            screenChoosed.scaleMode = .aspectFill
            self.view?.presentScene(screenChoosed, transition: SKTransition.fade(with: .black, duration: 1))
        })
        politics.zPosition = 10.0
        politics.setScale(0.45)
        politics.position = CGPoint(x: size.width/2.8 - (frame.width * 0.01), y: frame.midY - (frame.height / 8))
        return politics
    }()
    lazy var terms: CustomizedButton = {
        let terms = CustomizedButton(imageName: "background_button", lblText: "Termos de uso", buttonAction: {
            let screenChoosed = ScreenInfoChoosed(tela: 4, size: self.frame.size)
            screenChoosed.scaleMode = .aspectFill
            self.view?.presentScene(screenChoosed, transition: SKTransition.fade(with: .black, duration: 1))
        })
        terms.zPosition = 10.0
        terms.position = CGPoint(x: size.width/1.55 + (frame.width * 0.01), y: frame.midY - (frame.height / 8))
        terms.setScale(0.45)
        return terms
    }()
    
    
    //MARK: - Initializers
    override func didMove(to view: SKView) {
        addChild(self.bgNode)
    }
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setupNodes()
    }
}

//MARK: - Functions here
extension Info {
    func setupNodes() {
        self.addChild(self.icon)
        self.addChild(self.back)
        self.addChild(self.tutorial)
        self.addChild(self.credits)
        self.addChild(self.politics)
        self.addChild(self.terms)
    }
}


