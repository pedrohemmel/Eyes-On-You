//
//  GameScene.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var audioStatus: Bool = true
    
    let startText = SKLabelNode(fontNamed: "") //inserir a font quando definido a tipografia
    
    
    lazy var infoButton: InformationButton = {
        var button = InformationButton(imageName: "exclamation", buttonAction: {
            print("Funcionou")
        })
        button.zPosition = 1
        return button
    }()

    lazy var audioButton: InformationButton = {
        
        var volumeImage = "volumeBt"
        
        var button = InformationButton(imageName: volumeImage , buttonAction: {
            print("to aqui")
            
            if self.audioStatus == true{
                
                self.audioStatus = false
                SKAudio.sharedInstance().pauseBackgroundMusic()
                
                print(self.audioStatus)
                
                volumeImage = "volumeBt"
            }
            
            else if self.audioStatus == false {
    
                self.audioStatus = true
                
                SKAudio.sharedInstance().playBackgroundMusic("pipo.mp3")
                
                
                print(self.audioStatus)
                volumeImage = "exclamation"
            }
        
            
        })
        
        button.zPosition = 1
        return button
        
    }()
      
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.blue
        
        SKAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.5
        SKAudio.sharedInstance().playBackgroundMusic("pipo.mp3")
        
        
        //Adicionando o Botao a cena
        
        infoButton.position = CGPoint(x: frame.maxX-60, y: frame.maxY-25)
       
        self.addChild(infoButton)
        
        audioButton.position = CGPoint(x: frame.maxX-750, y: frame.maxY-25)
        
        
        self.addChild(audioButton)

        startText.text = "TOQUE NA TELA PARA INICIAR"
        startText.fontColor = UIColor.white
        startText.horizontalAlignmentMode = .center
        startText.verticalAlignmentMode = .bottom
        startText.position = CGPoint(x: frame.minX+430, y: frame.minY+30)
        
        
        
        self.addChild(startText)
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
