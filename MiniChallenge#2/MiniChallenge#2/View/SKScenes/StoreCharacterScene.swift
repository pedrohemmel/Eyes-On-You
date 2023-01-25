//
//  StoreCharacterScene.swift
//  MiniChallenge#2
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 27/12/22.
//

import Foundation
import SpriteKit

class StoreCharacterScene: SKScene {
    
    private var closeStoreBtn: CustomizedButton? = nil
    
//    private var titleOfStore: SKLabelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    private var imageOfStore: SKSpriteNode = SKSpriteNode(imageNamed: "cart.white")
    
    private var cardOfCharacterToSell: SKSpriteNode = SKSpriteNode()
    private var imageOfCharacter: SKSpriteNode = SKSpriteNode()
    private var nameOfCharacter: SKLabelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private var priceOfCharacter: SKSpriteNode = SKSpriteNode()
    private var buyButtonOfCharacter: CustomizedButton? = nil
    
    private var previousBtn: CustomizedButton? = nil
    private var nextBtn: CustomizedButton? = nil
    
    private var charactersToSell: [CharacterToSell] = DataLoaderOfCharacterToSell().charactersToSell
    private var indexOfCharacterToSell: Int? = nil
    
    override func didMove(to view: SKView) {
        
        //Setando o background da página
        self.backgroundColor = .black
        
        //Setando indice do personagem para vender ao entrar na cena
        self.indexOfCharacterToSell = 0
        
        //Criando botão de fechar loja
        self.closeStoreBtn = creatingCloseStoreButton()
        self.closeStoreBtn = settingPropertiesOfCloseStoreButton(button: self.closeStoreBtn!)
        
        //Criando icone de compras da página
        self.imageOfStore = self.creatingImageOfStore(image: self.imageOfStore)
        
        self.structuringCardOfCharacter(changedCharacter: false)
        
        self.insertingPreviousAndNextBtn(changedCharacter: false)
                
        //Adicionando objetos a cena
        self.addChild(self.closeStoreBtn!)
        self.addChild(self.imageOfStore)
        self.addChild(self.cardOfCharacterToSell)
        self.addChild(self.previousBtn!)
        self.addChild(self.nextBtn!)
    }
    
    
    //Função para criar botão juntamente à sua ação
    private func creatingCloseStoreButton() -> CustomizedButton {
        let button = CustomizedButton(imageName: "back", lblText: nil, buttonAction: {
            let gameScene = GameScene(size: self.frame.size)
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: SKTransition.fade(with: .black, duration: 1))
        })
        
        return button
    }
    
    private func creatingImageOfStore(image: SKSpriteNode) -> SKSpriteNode {
        image.setScale(1)
        image.zPosition = 2
        image.position = CGPoint(x: self.size.width / 2, y: self.size.height - 40)
        
        return image
    }
    
    private func structuringCardOfCharacter(changedCharacter: Bool) {
        if changedCharacter {
            self.cardOfCharacterToSell.removeAllChildren()
        }
        
        //Criação do card do personagem e seus objetos
        self.cardOfCharacterToSell = self.settingPropertiesInCardOdCharacterToSell(cardOfCharacterToSell: self.cardOfCharacterToSell)
        
        //Criando objetos do personagem e setando suas propriedades
        self.imageOfCharacter = self.creatingAndSettingPropertiesOfImageCharacter()
        self.nameOfCharacter = self.creatingAndSettingPropertiesOfNameCharacter()
        self.priceOfCharacter = self.creatingAndSettingPropertiesOfPriceCharacter()
        self.buyButtonOfCharacter = self.creatingAndSettingPropertiesOfBuyButtonOfCharacter()
        
        self.cardOfCharacterToSell = self.insertingObjectsInCardOfCharacterToSell(cardOfCharacterToSell: self.cardOfCharacterToSell)
    }
    
    private func insertingPreviousAndNextBtn(changedCharacter: Bool) {
        if changedCharacter {
            self.previousBtn?.removeFromParent()
            self.nextBtn?.removeFromParent()
            
            //Criação das setas para trocar de personagem
            self.previousBtn = self.settingPropertiesOfPreviousBtn()
            self.nextBtn = self.settingPropertiesOfNextBtn()
            
            self.addChild(self.previousBtn!)
            self.addChild(self.nextBtn!)
        } else {
            //Criação das setas para trocar de personagem
            self.previousBtn = self.settingPropertiesOfPreviousBtn()
            self.nextBtn = self.settingPropertiesOfNextBtn()
        }
        
    }
    
    //Função para setar propriedades do botão de sair
    private func settingPropertiesOfCloseStoreButton(button: CustomizedButton) -> CustomizedButton {
        
        button.setScale(0.25)
        button.zPosition = 10
        button.position = CGPoint(x: 40, y: self.size.height - 40)
        
        return button
    }
    
    private func settingPropertiesInCardOdCharacterToSell(cardOfCharacterToSell: SKSpriteNode) -> SKSpriteNode {
        
        cardOfCharacterToSell.size = CGSize(width: self.size.width - self.size.width / 3.25, height: self.size.height - self.size.height / 3)
        cardOfCharacterToSell.zPosition = 1
        cardOfCharacterToSell.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2.5)
        
        return cardOfCharacterToSell
    }
    
    private func insertingObjectsInCardOfCharacterToSell(cardOfCharacterToSell: SKSpriteNode) -> SKSpriteNode{
        
        self.cardOfCharacterToSell.addChild(self.imageOfCharacter)
        self.cardOfCharacterToSell.addChild(self.nameOfCharacter)
        self.cardOfCharacterToSell.addChild(self.priceOfCharacter)
        self.cardOfCharacterToSell.addChild(self.buyButtonOfCharacter!)
        
        return cardOfCharacterToSell
    }
    
    //Criando e setando propriedades da imagem do personagem
    private func creatingAndSettingPropertiesOfImageCharacter() -> SKSpriteNode {
        let imageOfCharacter = SKSpriteNode(imageNamed: self.charactersToSell[self.indexOfCharacterToSell!].imageName)
        
        imageOfCharacter.size = CGSize(width: self.cardOfCharacterToSell.frame.width / 3, height: self.cardOfCharacterToSell.frame.height)
        
        imageOfCharacter.zPosition = 2
        
        imageOfCharacter.position = CGPoint(x: -self.cardOfCharacterToSell.frame.width / 2 + imageOfCharacter.size.width / 2 + 30, y: 0)
        
        return imageOfCharacter
    }
    
    private func creatingAndSettingPropertiesOfNameCharacter() -> SKLabelNode {
        let nameOfCharacter = SKLabelNode(fontNamed: "AvenirNext-Bold")
        
        nameOfCharacter.text = self.charactersToSell[self.indexOfCharacterToSell!].name
        
        nameOfCharacter.fontSize = 25
        nameOfCharacter.fontColor = .white
        
        nameOfCharacter.horizontalAlignmentMode = .center
        nameOfCharacter.verticalAlignmentMode = .bottom
        
        nameOfCharacter.zPosition = 2
        
        nameOfCharacter.position = CGPoint(x: self.cardOfCharacterToSell.size.width / 2 - nameOfCharacter.frame.width / 2 - 30, y: self.cardOfCharacterToSell.size.height / 2 - nameOfCharacter.frame.height)
        
        return nameOfCharacter
    }

    private func creatingAndSettingPropertiesOfPriceCharacter() -> SKSpriteNode {
        
        //Sprite
        let priceOfCharacter = SKSpriteNode()
        
        priceOfCharacter.zPosition = 2
        //image
        let imagePriceOfCharacter = SKSpriteNode(imageNamed: "moedaCContraste")
        
        imagePriceOfCharacter.setScale(0.065)
        
        imagePriceOfCharacter.zPosition = 2
        
        //label
        let labelPriceOfCharacter = SKLabelNode(fontNamed: "AvenirNext-Bold")
        
        labelPriceOfCharacter.text = String(self.charactersToSell[self.indexOfCharacterToSell!].price)
        
        labelPriceOfCharacter.fontSize = 25
        labelPriceOfCharacter.fontColor = .white
        
        labelPriceOfCharacter.horizontalAlignmentMode = .center
        labelPriceOfCharacter.verticalAlignmentMode = .center
        
        labelPriceOfCharacter.zPosition = 2
        
        //size of priceOfCharacter
        priceOfCharacter.size = CGSize(width: labelPriceOfCharacter.frame.width + imagePriceOfCharacter.size.width, height: imagePriceOfCharacter.size.height)
        
        //Posição dos objetos
        imagePriceOfCharacter.position = CGPoint(x: -priceOfCharacter.size.width, y: 0)
        labelPriceOfCharacter.position = CGPoint(x: -priceOfCharacter.size.width + imagePriceOfCharacter.size.width + 30, y: 0)
        
        priceOfCharacter.position = CGPoint(x: self.cardOfCharacterToSell.size.width / 2 - 30, y: 0)
        
        priceOfCharacter.addChild(imagePriceOfCharacter)
        priceOfCharacter.addChild(labelPriceOfCharacter)
        
        return priceOfCharacter
    }
    
    private func creatingAndSettingPropertiesOfBuyButtonOfCharacter() -> CustomizedButton {
        let buyBtnOfCharacter = CustomizedButton(imageName: "background_button", lblText: "Comprar", buttonAction: {
            //Code here
        })
        buyBtnOfCharacter.setScale(0.5)
        buyBtnOfCharacter.position = CGPoint(x: self.cardOfCharacterToSell.size.width - buyBtnOfCharacter.buttonView.size.width, y: -self.cardOfCharacterToSell.size.height / 2 + 30)
        buyBtnOfCharacter.zPosition = 2
        
        return buyBtnOfCharacter
    }
    
    private func settingPropertiesOfPreviousBtn() -> CustomizedButton {
        
        let btn = CustomizedButton(imageName: "previousBtnStore", lblText: nil, buttonAction: {
            self.trocaDePersonagem(nextOrPrevious: "previous")
        })
        btn.setScale(1)
        btn.zPosition = 3
        btn.position = CGPoint(x: self.size.width / 2 - self.cardOfCharacterToSell.size.width / 1.75 + btn.frame.width / 2, y: self.size.height / 2.5)
        
        if self.indexOfCharacterToSell == 0 {
            btn.isHidden = true
        } else {
            btn.isHidden = false
        }
        return btn
    }
    
    private func settingPropertiesOfNextBtn() -> CustomizedButton {
        
        let btn = CustomizedButton(imageName: "nextBtnStore", lblText: nil, buttonAction: {
            self.trocaDePersonagem(nextOrPrevious: "next")
        })
        btn.setScale(1)
        btn.zPosition = 3
        btn.position = CGPoint(x: self.size.width / 2 + self.cardOfCharacterToSell.size.width / 1.75 - btn.frame.width / 2, y: self.size.height / 2.5)
        
        if self.indexOfCharacterToSell == (self.charactersToSell.count - 1) {
            btn.isHidden = true
        } else {
            btn.isHidden = false
        }
        return btn
    }
    
    private func trocaDePersonagem(nextOrPrevious: String) {
        if nextOrPrevious == "next" {
            self.indexOfCharacterToSell! += 1
        } else {
            self.indexOfCharacterToSell! -= 1
            
        }
        self.insertingPreviousAndNextBtn(changedCharacter: true)
        self.structuringCardOfCharacter(changedCharacter: true)
    }
    
    
}
