//
//  GameScene.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import SpriteKit

//Score.shared.addScore() usar essa func para adicionar score quando tiver
//Score.shared.trySaveHighScore() usar essa func para salvar o highscore

class GameScene: SKScene {
    
    var audioStatus: Bool = true
    
    let startText = SKLabelNode(fontNamed: "") //inserir a font quando definido a tipografia
    let highScoreText = SKLabelNode(fontNamed: "")
    
    lazy var infoButton: CustomizedButton = {
        var button = CustomizedButton(imageName: "exclamation", buttonAction: {
            
        })
        button.zPosition = 1
        return button
    }()

    
    
    lazy var audioButton: CustomizedButton = {
        
        var volumeImage = "volumeBt"
        
        var button = CustomizedButton(imageName: volumeImage , buttonAction: {
            print("to aqui")
         
            
            if self.audioStatus == true{
            
                self.audioStatus = false
                AVAudio.sharedInstance().pauseBackgroundMusic()
                
                print(self.audioStatus)
                
                volumeImage = "volumeBt"
            }
            
            else if self.audioStatus == false {
    
                self.audioStatus = true
                
                AVAudio.sharedInstance().playBackgroundMusic("pipo.mp3")
                
                
                print(self.audioStatus)
                volumeImage = "exclamation"
            }
        })
        
        button.zPosition = 1
        return button
        
    }()
      
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.blue
        
        AVAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.5
        AVAudio.sharedInstance().playBackgroundMusic("pipo.mp3")
        
        
        //Adicionando o Botao a cena
        
        highScoreText.text = ("\(Score.shared.highScore)") //mostra o highscore
        highScoreText.fontColor = UIColor.white
        highScoreText.fontSize = CGFloat(25)
        highScoreText.position = CGPoint(x: frame.maxX-95, y: frame.maxY-45)
        self.addChild(highScoreText)
        
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
