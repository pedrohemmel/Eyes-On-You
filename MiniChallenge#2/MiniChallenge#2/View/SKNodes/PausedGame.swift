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
        var button = CustomizedButton(imageName: "exclamation", buttonAction: {
            
            
        })
        return button
    }()
    
    var audioButton: CustomizedButton?
    
    //MARK: - Inicializador
    init(view: SKScene) {
        super.init()
        self.pausedGameToCreate(view: view)
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pausedGameToCreate(view: SKScene) -> Void {
        
        self.pausedGameEscope.color = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.pausedGameEscope.size = view.size
        self.pausedGameEscope.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.pausedGameEscope.zPosition = 1
        
        self.titlePaused.text = "Pausado"
        self.titlePaused.fontColor = UIColor.white
        self.titlePaused.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.titlePaused.zPosition = 2
        
//        self.btnGiveUp = CustomizedButton(imageName: <#T##String#>, buttonAction: <#T##() -> Void#>)
        
        self.addChild(self.titlePaused)
        self.addChild(self.pausedGameEscope)

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
//        self.addChild(self.startText)
    }
    
    func menuToPlayMusicBackground() {
        AVAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.5
        AVAudio.sharedInstance().playBackgroundMusic("pipo.mp3")
    }
    
    func menuStartTextToSetProperties(sizeView: CGSize) {
//        self.startText.text = "TOQUE NA TELA PARA INICIAR"
//        self.startText.fontColor = UIColor.white
//        self.startText.horizontalAlignmentMode = .center
//        self.startText.verticalAlignmentMode = .bottom
//        self.startText.position = CGPoint(x: sizeView.width / 2, y: 40)
    }
    
    func menuAudioButtonToSetProperties(sizeView: CGSize) {
        self.audioButton!.position = CGPoint(x: 40, y: sizeView.height - 40)
    }
    
    func menuInfoButtonToSetProperties(sizeView: CGSize) {
        self.infoButton.position = CGPoint(x: sizeView.width - 40, y: sizeView.height - 40)
    }
    
    func menuHighScoreToSetProperties(sizeView: CGSize) {
        self.highScoreText.text = ("High Score: \(Score.shared.highScore)")
        self.highScoreText.fontColor = UIColor.white
        self.highScoreText.fontSize = CGFloat(25)
        self.highScoreText.position = CGPoint(x: sizeView.width - 80 - self.highScoreText.frame.width, y: sizeView.height - 50)
    }
      
    func tapToStart(){

//        if !startGame {
//
//            startText.isHidden = true
//            highScoreText.isHidden = true
//            infoButton.isHidden = true
//            audioButton?.isHidden = true
//            startGame = true
//            Score.shared.scoreLabel.isHidden = false
//        }
//
//        func restart(){
//            //colocar oq acontece para restart
//
//
//
//        }
//
//        func endGame(){
//
//
//
//
//        }
        self.isHidden = true

    }
    
    
}
