//
//  CenaTeste.swift
//  MiniChallenge#2
//
//  Created by Gustavo Assis on 30/11/22.
//

import SpriteKit
import Foundation

class ScreenInfoChoosed : SKScene {
    

    public var tela: Int
    
    
    
    //MARK: - Systems
    
    override func didMove(to view: SKView) {
        setupBG()
    }
    
    override func sceneDidLoad() {
        setupNodes()
        chooseScreen(tela: tela)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tela: Int, size: CGSize) {
        self.tela = tela

        super.init(size: size)

    }
}


    
    //MARK: - Configurations
    
    extension ScreenInfoChoosed {
        
        func setupBG() {
            let bgNode = SKSpriteNode(color: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1), size: CGSize(width: frame.width, height: frame.height))
            bgNode.zPosition = -1.0
            bgNode.anchorPoint = .zero
            bgNode.position = .zero
            addChild(bgNode)
        }
        
        func setupNodes() {
            
            let back = CustomizedButton(imageName: "back", buttonAction: {
                let info = Info(size: self.frame.size)
                info.scaleMode = .aspectFill
                self.view?.presentScene(info, transition: SKTransition.fade(with: .green, duration: 1))
            })
            back.setScale(0.3)
            back.zPosition = 10.0
            back.position = CGPoint(x: frame.minX + 70, y: frame.maxY - 50)
            addChild(back)
        }
        
        func chooseScreen(tela: Int){
            
            switch tela {
                case 1:
                    setupTutorial()
                          
                case 2:
                    setupCredits()
                    
                case 3:
                    print("tela 3")
                    
                default:
                    print("tela 4")
            }
            
        }
        
        func setupTutorial(){
            let texto = SKLabelNode(fontNamed: "")
            texto.text = "vai ficar os textos 2022-12-01 17:5 4:57.057569-0300 miniChallenge#2 [25539:782849] Metal API Validation Enabledaqui dentro aqui 022-12-01 17:54:57.057569-0300 MiniChallenge#2[25539:782849] Metal API Vali vai ficar os textos aqui dentro aaaa "
            texto.lineBreakMode = NSLineBreakMode.byWordWrapping
            texto.fontSize = 20
            texto.position = CGPoint(x: frame.midX, y: frame.midY - 100)
            texto.preferredMaxLayoutWidth = frame.width * 0.8
            texto.lineBreakMode = NSLineBreakMode.byWordWrapping
            texto.numberOfLines = 0
            addChild(texto)
        }
        
        func setupCredits(){
            
            let icon = SKSpriteNode(imageNamed: "cc")
            icon.setScale(1.1)
            icon.zPosition = 10.0
            icon.position = CGPoint(x: frame.midX, y: frame.height - 50 )
            addChild(icon)
            
            
            
            let texto = SKLabelNode()
            texto.text = "TESTE222"
            texto.fontSize = 20
            texto.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(texto)
        }
        
        
        
        
    }
    

