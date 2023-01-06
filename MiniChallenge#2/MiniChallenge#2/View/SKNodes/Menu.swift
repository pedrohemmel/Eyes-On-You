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
    
    let backgroundMenu = SKSpriteNode()
    
    let startText = SKLabelNode(fontNamed: "")
    let highScoreText = SKLabelNode(fontNamed: "")
    
    let coinText = SKLabelNode(fontNamed: "")
    var imageCoinText = SKSpriteNode()
    
    var imageHighScoreText = SKSpriteNode()
    
    var infoButton: CustomizedButton? = nil
    
    var audioButtonOn: CustomizedButton?
    var audioButtonOff: CustomizedButton?
    
    //MARK: - Inicializador
    init(infoButtonAction: @escaping () -> Void) {
        super.init()
    
        //Criando os botões de configuração do menu
        self.menuToCreateButtonInfo(infoButtonAction: infoButtonAction)
        self.menuToCreateButtonOn()
        self.menuToCreateButtonOff()
        
        //Setando icone de som mutado escondido na tela por padrão
        audioButtonOff?.isHidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Funções de estruturação da classe
    func menuToStruct(sizeView: CGSize) {
        
        self.zPosition = 4
        
        self.backgroundMenu.color = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.backgroundMenu.size = sizeView
        self.backgroundMenu.position = CGPoint(x: sizeView.width / 2, y: sizeView.height / 2)
        self.backgroundMenu.zPosition = 4
        
        self.menuCoinToSetProperties(sizeView: sizeView)
        self.coinText.zPosition = 5
        self.imageCoinText.zPosition = 5
        self.addChild(self.coinText)
        self.addChild(self.imageCoinText)
        
        self.menuHighScoreToSetProperties(sizeView: sizeView)
        self.highScoreText.zPosition = 5
        self.imageHighScoreText.zPosition = 5
        self.addChild(self.imageHighScoreText)
        self.addChild(self.highScoreText)
        
        self.menuInfoButtonToSetProperties(sizeView: sizeView)
        self.infoButton!.zPosition = 5
        self.addChild(self.infoButton!)

        self.menuAudioButtonToSetProperties(sizeView: sizeView)
        self.audioButtonOn!.zPosition = 5
        self.addChild(self.audioButtonOn!)
        
        self.menuAudioButtonToSetProperties(sizeView: sizeView)
        self.audioButtonOff!.zPosition = 5
        self.addChild(self.audioButtonOff!)

        self.menuStartTextToSetProperties(sizeView: sizeView)
        self.startText.zPosition = 5
        self.addChild(self.startText)
    }
    
    //Criação do botão de informações
    func menuToCreateButtonInfo(infoButtonAction: @escaping () -> Void) {
        self.infoButton = {
            let button = CustomizedButton(imageName: "exclamation", buttonAction: {
                infoButtonAction()
            })
            return button
        }()
    }
    
    //Criação do botão de som ativo
    func menuToCreateButtonOn() {
        self.audioButtonOn = {
            let buttonOn = CustomizedButton(imageName: "volumeBtOn", buttonAction: {
                AVAudio.sharedInstance().pauseBackgroundMusic()
                self.audioStatus = false
                self.audioButtonOff!.isHidden = false
                self.audioButtonOn!.isHidden = true
            })
            return buttonOn
        }()
    }
    
    //Criação do botão de som desativado
    func menuToCreateButtonOff() {
        self.audioButtonOff = {
            let buttonOff = CustomizedButton(imageName: "volumeBtOff", buttonAction: {
                AVAudio.sharedInstance().playBackgroundMusic("noite.mp3")
                self.audioStatus = true
                self.audioButtonOff!.isHidden = true
                self.audioButtonOn!.isHidden = false
            })
            return buttonOff
        }()
    }
    
    func menuToPlayMusicBackground() {
        AVAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.5
        AVAudio.sharedInstance().playBackgroundMusic("noite.mp3")
    }
    
    func menuStartTextToSetProperties(sizeView: CGSize) {
        self.startText.text = "TOQUE NA TELA PARA INICIAR".localizedLanguage()
        self.startText.fontName = "AvenirNext-Bold"
//        self.startText.fontColor = UIColor(displayP3Red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        self.startText.fontColor = .black
        self.startText.horizontalAlignmentMode = .center
        self.startText.verticalAlignmentMode = .bottom
        self.startText.position = CGPoint(x: sizeView.width / 2, y: sizeView.height / 2)
    }
    
    func menuAudioButtonToSetProperties(sizeView: CGSize) {
        
        self.audioButtonOn!.position = CGPoint(x: 40, y: sizeView.height - 40)
        self.audioButtonOff!.position = CGPoint(x: 40, y: sizeView.height - 40)
        
        self.audioButtonOn!.buttonView.setScale(0.25)
        self.audioButtonOff!.buttonView.setScale(0.25)
    }
    
    func menuInfoButtonToSetProperties(sizeView: CGSize) {
        self.infoButton!.position = CGPoint(x: sizeView.width - 40, y: sizeView.height - 40)
        self.infoButton?.buttonView.setScale(0.25)
    }
    
    func menuCoinToSetProperties(sizeView:CGSize) {
        self.coinText.text = ("\(SavePrize.shared.saveCoin)") //inserir o userDefaults do coin
        self.coinText.fontName = "AvenirNext-Bold"
        self.coinText.fontColor = .black
        self.coinText.fontSize = CGFloat(25)
        self.coinText.position = CGPoint(x: sizeView.width - 280, y: sizeView.height - 50)
        
        self.imageCoinText = SKSpriteNode(imageNamed: "moedaCContraste")
        self.imageCoinText.setScale(0.07)
        self.imageCoinText.position = CGPoint(x: sizeView.width - 340, y: sizeView.height - 38)
    }
    func menuToUpdateCountOfCoin() {
        self.coinText.text = ("\(SavePrize.shared.saveCoin)")
    }
    
    func menuHighScoreToSetProperties(sizeView: CGSize) {
        
        self.imageHighScoreText = SKSpriteNode(imageNamed: "highscore_icon")
        self.imageHighScoreText.setScale(0.4)
        self.imageHighScoreText.position = CGPoint(x: sizeView.width - 180 , y: sizeView.height - 35)
        
        self.highScoreText.text = ("\(Score.shared.highScore)")
        self.highScoreText.fontName = "AvenirNext-Bold"
        self.highScoreText.fontColor = .black
        self.highScoreText.fontSize = CGFloat(25)
        self.highScoreText.position = CGPoint(x: sizeView.width - 120, y: sizeView.height - 50)
    }
    
    func tapToRestart() {
        self.isHidden = false
        startGame = false
        Score.shared.scoreLabel.isHidden = true
    }
      
    func tapToStart(){
        self.isHidden = true
        startGame = true
        Score.shared.scoreLabel.isHidden = false
    }
    
}
