//
//  Menu.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 23/11/22.
//

import Foundation
import SpriteKit

class Menu: SKNode {
    
    //MARK: - Criando as variáveis principais
    var audioStatus: Bool = true
    
    let startText = SKLabelNode(fontNamed: "")
    let highScoreText = SKLabelNode(fontNamed: "")
    
    var infoButton: CustomizedButton = {
        var button = CustomizedButton(imageName: "exclamation", buttonAction: {
            
        })
        return button
    }()
    
    var audioButton: CustomizedButton?
    
    //MARK: - Inicializador
    override init() {
        super.init()
        
        self.audioButton = menuToCreateAudioButton()
        
        self.menuToStruct()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func menuToCreateAudioButton() -> CustomizedButton {
        
        var volumeImage = "volumeBt"
        
        return CustomizedButton(imageName: volumeImage , buttonAction: {
            
            if self.audioStatus == true {
            
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
    }
    //MARK: - Funções de estruturação da classe
    func menuToStruct() {
        self.menuToPlayMusicBackground()
        
        self.menuHighScoreToSetProperties()
        self.addChild(self.highScoreText)
        
        self.menuInfoButtonToSetProperties()
        self.addChild(self.infoButton)
        
        self.menuAudioButtonToSetProperties()
        self.addChild(self.audioButton!)

        self.menuStartTextToSetProperties()
        self.addChild(self.startText)
    }
    
    func menuToPlayMusicBackground() {
        AVAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.5
        AVAudio.sharedInstance().playBackgroundMusic("pipo.mp3")
    }
    
    func menuStartTextToSetProperties() {
        self.startText.text = "TOQUE NA TELA PARA INICIAR"
        self.startText.fontColor = UIColor.white
        self.startText.horizontalAlignmentMode = .center
        self.startText.verticalAlignmentMode = .bottom
        self.startText.position = CGPoint(x: frame.minX+430, y: frame.minY+30)
    }
    
    func menuAudioButtonToSetProperties() {
        self.audioButton!.position = CGPoint(x: frame.maxX+20, y: frame.maxY+200)
    }
    
    func menuInfoButtonToSetProperties() {
        self.infoButton.position = CGPoint(x: frame.maxX+400, y: frame.maxY+200)
    }
    
    func menuHighScoreToSetProperties() {
        self.highScoreText.text = ("\(Score.shared.highScore)") //mostra o highscore
        self.highScoreText.fontColor = UIColor.white
        self.highScoreText.fontSize = CGFloat(25)
        self.highScoreText.position = CGPoint(x: frame.maxX-95, y: frame.maxY-45)
    }
      
    
}
