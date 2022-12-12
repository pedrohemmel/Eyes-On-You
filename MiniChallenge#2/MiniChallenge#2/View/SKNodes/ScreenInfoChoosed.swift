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
            back.setScale(0.25)
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
            
            let illustrations = SKLabelNode(fontNamed: "")
            illustrations.text = "Ilustrações e design"
            illustrations.fontSize = 20
            illustrations.position = CGPoint(x: frame.minX + 180, y: frame.height - 120)
            addChild(illustrations)
            
            let design = SKLabelNode(fontNamed: "")
            design.text = "Aline Reis Silva"
            design.fontSize = 16
            design.position = CGPoint(x: frame.minX + 149, y: frame.height - 150)
            addChild(design)
            
            let development = SKLabelNode(fontNamed: "")
            development.text = "Desenvolvimento"
            development.fontSize = 20
            development.position = CGPoint(x: frame.maxX - 260, y: frame.height - 120)
            addChild(development)
            
            let devs = SKLabelNode(fontNamed: "")
            devs.text = """
                        Gustavo Assis, Higor Crisostomo,
                        Marcelo Araujo e Pedro Henrique Souza.
                        """
            devs.fontSize = 16
            devs.preferredMaxLayoutWidth = 500
            devs.numberOfLines = 0
            devs.position = CGPoint(x: frame.midX + 205, y: frame.height - 173)
            addChild(devs)
            
            let soundTrack = SKLabelNode(fontNamed: "")
            soundTrack.text = "Soundtrack"
            soundTrack.fontSize = 20
            soundTrack.position = CGPoint(x: frame.minX + 140, y: frame.midY - 15)
            addChild(soundTrack)
            
            
            let firstLine = createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 50),
                                                 firstIconName: "cc_icon",
                                                 zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 50),
                                                 secIconName: "zero_icon",
                                                 text: "052216 matsushima cemetery of pflanigan is licenced under CC0 1.0 Universal",
                                                 textPos: CGPoint(x: frame.midX + 18, y: frame.midY - 57))
            self.addChild(firstLine)
            
            
            let secLine = createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 80),
                                               firstIconName: "cc_icon",
                                               zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 80),
                                               secIconName: "zero_icon",
                                               text: "Ghost Scream of onderwish is licenced under CC0 1.0 Universal",
                                               textPos: CGPoint(x: frame.midX - 33, y: frame.midY - 87))
            self.addChild(secLine)
            
            
            let terLine =  createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 110),
                                                firstIconName: "cc_icon",
                                                zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 110),
                                                secIconName: "zero_icon",
                                                text: "Impacts of Anuj_Shrestha1 is licenced under CC0 1.0 Universal",
                                                textPos: CGPoint(x: frame.midX - 33, y: frame.midY - 117))
             self.addChild(terLine)
            
            
            let forLine = createLineSoundTrack(ccPos: CGPoint(x: frame.minX + 100, y: frame.midY - 140),
                                               firstIconName: "cc_icon",
                                               zeroPos: CGPoint(x: frame.minX + 135, y: frame.midY - 140),
                                               secIconName: "person_icon",
                                               text: "The Cemetery of TheRedLetterDay is licenced under CC BY 4.0",
                                               textPos: CGPoint(x: frame.midX - 33, y: frame.midY - 147))
            self.addChild(forLine)

        }
        
        func iconsCC(firstIcon: CGPoint, firstIconName: String, secIcon: CGPoint, secIconName: String ) -> [SKSpriteNode] {
            let ccIcon = SKSpriteNode(imageNamed: firstIconName)
            ccIcon.setScale(0.85)
            ccIcon.zPosition = 10.0
            ccIcon.position = firstIcon
            
            let zeroIcon = SKSpriteNode(imageNamed: secIconName)
            zeroIcon.setScale(0.85)
            zeroIcon.zPosition = 10.0
            zeroIcon.position = secIcon
            return [ccIcon, zeroIcon]
        }
        
        func createLineSoundTrack(ccPos: CGPoint, firstIconName: String, zeroPos: CGPoint, secIconName: String, text: String, textPos: CGPoint) -> SKNode {
            let line = SKNode()
            for i in iconsCC(firstIcon: ccPos, firstIconName: firstIconName, secIcon: zeroPos, secIconName: secIconName) {
                line.addChild(i)
            }
            
            let txt = SKLabelNode(fontNamed: "")
            txt.text = text
            txt.fontSize = 15
            txt.position = textPos
            line.addChild(txt)
            return line
        }
        
    }
    

