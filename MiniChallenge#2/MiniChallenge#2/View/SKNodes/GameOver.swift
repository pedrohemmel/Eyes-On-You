//
//  GameOver.swift
//  MiniChallenge#2
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 02/12/22.
//

import Foundation
import SpriteKit

class GameOver: SKNode {
    //MARK: - Criando as variáveis principais
    
    private var gameOverEscope: SKSpriteNode = SKSpriteNode(imageNamed: "gameover_background")

    private var btnRestart: CustomizedButton? = nil
    
    let titleGameOver = SKLabelNode(fontNamed: "")
    
    var audioButton: CustomizedButton?
    
    //MARK: - Inicializador
    init(view: SKScene) {
        super.init()
        self.gameOverToCreate(view: view)
        
        //Mudar para true no momento em que eu quiser que a tela pausada apareça
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gameOverToCreate(view: SKScene) -> Void {
        
        self.gameOverEscope.color = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.gameOverEscope.size = view.size
        self.gameOverEscope.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.gameOverEscope.zPosition = 4
        
        self.titleGameOver.text = "Game Over"
        self.titleGameOver.fontColor = UIColor.white
        self.titleGameOver.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.5)
        self.titleGameOver.zPosition = 5
       
        self.addChild(self.titleGameOver)
        self.addChild(self.gameOverEscope)

    }
    
    func creatingRestartButton(view: SKScene, actionOfBtnRestart: @escaping() -> Void) -> Void {
        self.btnRestart = CustomizedButton(imageName: "btnReiniciar", buttonAction: {
            actionOfBtnRestart()
        })
        self.btnRestart!.setScale(0.5)
        self.btnRestart!.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 3)
        self.btnRestart!.zPosition = 5
        
        self.addChild(self.btnRestart!)
    }
    

}
