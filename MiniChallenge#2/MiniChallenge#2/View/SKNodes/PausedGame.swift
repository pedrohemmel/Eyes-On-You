//
//  PausedGame.swift
//  MiniChallenge#2
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 01/12/22.
//

import Foundation
import SpriteKit

class PausedGame: SKNode {
    
    //MARK: - Criando as variáveis principais
    
    private var pausedGameEscope: SKSpriteNode = SKSpriteNode()

    private var btnGiveUp: CustomizedButton? = nil
    private var btnRestart: CustomizedButton? = nil
    private var btnContinue: CustomizedButton? = nil
   
    var audioStatus: Bool = true
    var startGame: Bool = false
    var endGame: Bool = false
    var restartGame: Bool = false
    
    var testeBg: Int = 1
    
    let titlePaused = SKLabelNode(fontNamed: "")
    let highScoreText = SKLabelNode(fontNamed: "")
    
    
    
    var infoButton: CustomizedButton = {
        var button = CustomizedButton(imageName: "exclamation", lblText: nil, buttonAction: {
            
            
        })
        return button
    }()
    
    var audioButton: CustomizedButton?
    
    //MARK: - Inicializador
    init(view: SKScene) {
        super.init()
        self.pausedGameToCreate(view: view)
        
        //Mudar para true no momento em que eu quiser que a tela pausada apareça
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pausedGameToCreate(view: SKScene) -> Void {
        
        self.pausedGameEscope.color = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.pausedGameEscope.size = view.size
        self.pausedGameEscope.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.pausedGameEscope.zPosition = 4
        
        self.titlePaused.text = "Pausado".localizedLanguage()
        self.titlePaused.fontName = "AvenirNext-Bold"
        self.titlePaused.fontColor = UIColor.white
        self.titlePaused.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.5)
        self.titlePaused.zPosition = 5
       
        self.addChild(self.titlePaused)
        self.addChild(self.pausedGameEscope)

    }
    
    func creatingAllButtons(view: SKScene, actionOfBtnGiveUp: @escaping() -> Void, actionOfBtnContinue: @escaping() -> Void) -> Void {
        self.btnGiveUp = CustomizedButton(imageName: "background_button", lblText: "Desistir", buttonAction: {
            actionOfBtnGiveUp()
        })
        self.btnGiveUp!.setScale(0.5)
        self.btnGiveUp!.position = CGPoint(x: view.frame.width / 3, y: view.frame.height / 3)
        self.btnGiveUp!.zPosition = 5
        
        self.btnContinue = CustomizedButton(imageName: "background_button", lblText: "Continuar", buttonAction: {
            actionOfBtnContinue()
        })
        self.btnContinue!.setScale(0.5)
        self.btnContinue!.position = CGPoint(x: view.frame.width / 1.5, y: view.frame.height / 3)
        self.btnContinue!.zPosition = 5
        
        self.addChild(self.btnGiveUp!)
        self.addChild(self.btnContinue!)
    }
    

    
    
}
