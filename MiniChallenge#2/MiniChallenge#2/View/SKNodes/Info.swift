//
//  Info.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 30/11/22.
//

import SpriteKit


class Info: SKScene {
    
    //MARK: - Systems
    override func didMove(to view: SKView) {
        setupBG()
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setupNodes()
    }
}

//MARK: - Configurations

extension Info {
    func setupBG() {
        let bgNode = SKSpriteNode(color: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1), size: CGSize(width: frame.width, height: frame.height))
        bgNode.zPosition = -1.0
        bgNode.anchorPoint = .zero
        bgNode.position = .zero
        addChild(bgNode)
    }
    
    func setupNodes() {
        
        let icon = SKSpriteNode(imageNamed: "i")
        icon.setScale(0.3)
        icon.zPosition = 10.0
        icon.position = CGPoint(x: frame.midX, y: frame.height - 50 )
        addChild(icon)
        
        
        let back = CustomizedButton(imageName: "back", buttonAction: {
            let telaGameScene = GameScene(size: self.frame.size)
            telaGameScene.scaleMode = .aspectFill
            self.view?.presentScene(telaGameScene, transition: SKTransition.fade(with: .black, duration: 1))
        })
        back.setScale(0.25)
        back.zPosition = 10.0
        back.position = CGPoint(x: frame.minX + 70, y: frame.height - 50)
        addChild(back)
        
        
        let tutorial = CustomizedButton(imageName: "tutorial", buttonAction: {
            let proximaTela = ScreenInfoChoosed(tela: 1, size: self.frame.size)
            proximaTela.scaleMode = .aspectFill
            self.view?.presentScene(proximaTela,transition: SKTransition.flipHorizontal(withDuration: 1))
        })
        
        tutorial.zPosition = 10.0
        tutorial.position = CGPoint(x: size.width/2.95, y: frame.midY + tutorial.frame.height + 25)
        tutorial.setScale(0.45)
//        addChild(tutorial)
        
        
        let credits = CustomizedButton(imageName: "creditos", buttonAction: {
            let proximaTela = ScreenInfoChoosed(tela: 2, size: self.frame.size)
            proximaTela.scaleMode = .aspectFill
            self.view?.presentScene(proximaTela, transition: SKTransition.fade(with: .black, duration: 1))
        })

        credits.zPosition = 10.0
//        credits.position = CGPoint(x: size.width/1.5, y: frame.midY + credits.frame.height + 25)
        credits.position = CGPoint(x: size.width / 2, y: frame.height / 2)
        credits.setScale(0.45)
        addChild(credits)
        
        
        let politcs = CustomizedButton(imageName: "politicasdepriv", buttonAction: {
            let proximaTela = ScreenInfoChoosed(tela: 3, size: self.frame.size)
            proximaTela.scaleMode = .aspectFill
            self.view?.presentScene(proximaTela,transition: SKTransition.flipHorizontal(withDuration: 1))
        })

        politcs.zPosition = 10.0
        politcs.position = CGPoint(x: size.width/2.95, y: frame.midY + politcs.frame.height - 90 )
        politcs.setScale(0.45)
//        addChild(politcs)
        
        
        let terms = CustomizedButton(imageName: "termosdeuso", buttonAction: {
            let proximaTela = ScreenInfoChoosed(tela: 4, size: self.frame.size)
            proximaTela.scaleMode = .aspectFill
            self.view?.presentScene(proximaTela,transition: SKTransition.flipHorizontal(withDuration: 1))
        })

        terms.zPosition = 10.0
        terms.position = CGPoint(x: size.width/1.5, y: frame.midY + terms.frame.height - 90 )
        terms.setScale(0.45)
//        addChild(terms)
                
    }
}


