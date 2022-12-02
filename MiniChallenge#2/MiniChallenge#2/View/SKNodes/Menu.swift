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
    var startGame: Bool = false
    var endGame: Bool = false
    var restartGame: Bool = false
    
    var testeBg: Int = 1
    
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
    func menuToStruct(sizeView: CGSize) {
        self.menuToPlayMusicBackground()
        
        self.menuHighScoreToSetProperties(sizeView: sizeView)
        self.addChild(self.highScoreText)
        
        self.menuInfoButtonToSetProperties(sizeView: sizeView)
        self.addChild(self.infoButton)
        
        self.menuAudioButtonToSetProperties(sizeView: sizeView)
        self.addChild(self.audioButton!)

        self.menuStartTextToSetProperties(sizeView: sizeView)
        self.addChild(self.startText)
    }
    
    func menuToPlayMusicBackground() {
        AVAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.5
        AVAudio.sharedInstance().playBackgroundMusic("pipo.mp3")
    }
    
    func menuStartTextToSetProperties(sizeView: CGSize) {
        self.startText.text = "TOQUE NA TELA PARA INICIAR"
        self.startText.fontColor = UIColor.white
        self.startText.horizontalAlignmentMode = .center
        self.startText.verticalAlignmentMode = .bottom
        self.startText.position = CGPoint(x: sizeView.width / 2, y: 40)
    }
    
    func menuAudioButtonToSetProperties(sizeView: CGSize) {
        self.audioButton!.position = CGPoint(x: 40, y: sizeView.height - 40)
    }
    
    func menuInfoButtonToSetProperties(sizeView: CGSize) {
        self.infoButton.position = CGPoint(x: sizeView.width - 40, y: sizeView.height - 40)
    }
    
    func menuHighScoreToSetProperties(sizeView: CGSize) {
        self.highScoreText.text = ("High Score: \(Score.shared.highScore)") //mostra o highscore
        self.highScoreText.fontColor = UIColor.white
        self.highScoreText.fontSize = CGFloat(25)
        self.highScoreText.position = CGPoint(x: sizeView.width - 80 - self.highScoreText.frame.width, y: sizeView.height - 50)
    }
      
    func tapToStart(){
        
        if !startGame {
            
            startText.isHidden = true
            highScoreText.isHidden = true
            infoButton.isHidden = true
            audioButton?.isHidden = true
            startGame = true
            
            testeBg = 2
            
            print(testeBg)
            
        }
    }
    
}
