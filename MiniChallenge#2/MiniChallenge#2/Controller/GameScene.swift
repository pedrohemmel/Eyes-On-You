//
//  GameScene.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    lazy var infoButton: InformationButton = {
        var button = InformationButton(imageName: "exclamation", buttonAction: {
            print("Funcionou")
        })
        button.zPosition = 1
        return button
    }()

    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
  
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.blue
        
        //Adicionando o Botao a cena
        
        infoButton.position = CGPoint(x: frame.maxX-60, y: frame.maxY-25)
       
        self.addChild(infoButton)

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
