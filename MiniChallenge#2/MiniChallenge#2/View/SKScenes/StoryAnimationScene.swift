//
//  StoryAnimationScene.swift
//  MiniChallenge#2
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 12/12/22.
//

import Foundation
import SpriteKit
import GameplayKit

class StoryAnimationScene: SKScene, SKPhysicsContactDelegate {
    private var backgroundImage = SKSpriteNode()
    private var animationOfBackground = SKNode()
    
    private let character = Character.character
    private var deadCharacter = SKSpriteNode()
    
    private var gateStatic = GateObstacle()
    private var gateDynamic = GateObstacle()
    private var animationOfGate: SKAction? = nil
    
    private var collisionAllowed = true
    
    private var ground = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //Setando propriedades do personagem principal vivo
        self.character.characterView = AnimatedObject("personagem_vivo")
        self.character.characterView = character.characterToApplyProperties(character: character.characterView, view: self, zPosition: 2)
        self.character.characterView = character.characterToCollide(character: character.characterView)
        self.character.characterLife = character.characterLifeToSetProperties(characterLife: self.character.characterLife, view: self)
        
        //Criando background animado
        self.creatingAnimatedBackground()
        
        //Criando o objeto solo
        self.ground = groundToCreate(ground: SKSpriteNode(imageNamed: "chao"))
        self.ground.zPosition = 2
        
        //Criando portao estático e setando suas propriedades
        self.gateStatic.obstacleView = SKSpriteNode(imageNamed: "portaoEstatico")
        self.gateStatic.obstacleView = self.creatingStaticGate(gate: self.gateStatic.obstacleView)
        
        //Criando ação que ocorrerá no portão
        self.animationOfGate = SKAction.moveBy(x: -self.frame.width, y: 0, duration: 10)
        
        //Ativando animação do portão
        self.gateStatic.obstacleView.run(self.animationOfGate!)
        
        self.addChild(self.character.characterView)
        self.addChild(self.animationOfBackground)
        self.addChild(self.ground)
        self.addChild(self.gateStatic.obstacleView)
        
    }
    
    //Criando animação personagem queda e escondendo personagem vivo
    func creatingFallCharacterAnimationAndRemovingActualCharacter() {
        self.deadCharacter = AnimatedObject("animacao_queda", countRepeat: 1, lastImageDesired: 4)
        self.deadCharacter.setScale(0.13)
        self.deadCharacter.position = CGPoint(x: 250, y: 100)
        self.deadCharacter.zPosition = 3
        
        self.deadCharacter.run(SKAction.moveBy(x: 0, y: -40, duration: 0.5))
        
        self.addChild(self.deadCharacter)
         
        self.character.characterView.isHidden = true
    }
    
    func creatingStaticGate(gate: SKSpriteNode) -> SKSpriteNode {
        
        gate.setScale(0.2)
        gate.position = CGPoint(x: self.frame.width / 2, y: self.ground.frame.height + (gate.frame.height / 2) - 18)
        gate.zPosition = 4
        
        gate.physicsBody = SKPhysicsBody(texture: gate.texture!, size: gate.size)
        gate.physicsBody?.isDynamic = false
        gate.physicsBody?.affectedByGravity = false
        
        gate.physicsBody?.categoryBitMask = PhysicsCategory.gate
        gate.physicsBody?.contactTestBitMask = PhysicsCategory.character
        
        return gate
    }
    
    //Criando portão dinâmico que será adicionado no momento em que o personagem fazer contato com o portao
    func creatingDynamicGate(gate: SKSpriteNode) -> SKSpriteNode {
        gate.setScale(0.2)
        gate.position = self.gateStatic.obstacleView.position
        gate.zPosition = 4
        
        return gate
    }

    //Função que estrutura toda a parte do background animado
    func creatingAnimatedBackground() -> Void{
        let moveBackground = SKAction.moveBy(x: -self.frame.width, y: 0, duration: 10)
        let resizeBackground = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let reDo = SKAction.repeat((SKAction.sequence([moveBackground, resizeBackground])), count: 1)

        for i in 0..<2 {
            if(i == 1) {
                self.backgroundImage = SKSpriteNode(imageNamed: "bg")
            } else {
                self.backgroundImage = SKSpriteNode(imageNamed: "background_inicio")
            }

            //Setando propriedades da imagem
            self.backgroundImage.anchorPoint = CGPoint(x: 0, y:0)
            self.backgroundImage.size.width = self.size.width * 2 //get the right pixel on phone
            self.backgroundImage.size.height = self.size.height
            self.backgroundImage.zPosition = 1 //Z positions define what itens comes in front goes from ex: 0,1,2,3 etc
            
            if i == 1 {
                self.backgroundImage.position = CGPoint(x: self.backgroundImage.frame.width - 1, y:0)
            } else {
                self.backgroundImage.position = CGPoint(x: 0, y:0)
            }
            
            self.backgroundImage.run(reDo)

            self.animationOfBackground.addChild(backgroundImage)
        }

        self.animationOfBackground.speed = 1
    }
    
    //Criando chão do ambiente
    func groundToCreate(ground: SKSpriteNode) -> SKSpriteNode {
        ground.size = CGSize(width: self.frame.width, height: 60)
        ground.position = CGPoint(x: self.frame.width / 2, y: 30)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        ground.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
        
        return ground
    }
    
    func creatingNewGateAndStopingAnimation() {
        self.gateDynamic.obstacleView = AnimatedObject("portao", countRepeat: 1, lastImageDesired: 3)
        self.gateDynamic.obstacleView = self.creatingDynamicGate(gate: self.gateDynamic.obstacleView)
        
        self.gateStatic.obstacleView.removeAllActions()
        self.gateStatic.obstacleView.removeFromParent()
        self.addChild(self.gateDynamic.obstacleView)
    }
    
    func generatingGhostOfCharacter() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.deadCharacter.isHidden = true
            
            
            self.character.characterView.removeFromParent()
            
            //Setando propriedades do personagem principal vivo
            self.character.characterView = AnimatedObject("personagem_alma")
            self.character.characterView = self.character.characterToApplyProperties(character: self.character.characterView, view: self, zPosition: 2)
            self.character.characterView = self.character.characterToCollide(character: self.character.characterView)
            self.character.characterLife = self.character.characterLifeToSetProperties(characterLife: self.character.characterLife, view: self)
            
            self.addChild(self.character.characterView)
            
            
        }
    }
    
    //Função que aguarda o personagem passar pelo portao para ativar animacao
    func waitingForCharacterToActivateGateAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            //Parando animação do background
            self.animationOfBackground.isPaused = true
            
            //Criando o novo portao animado e removendo o stático
            self.creatingNewGateAndStopingAnimation()
            self.creatingFallCharacterAnimationAndRemovingActualCharacter()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                AVAudio.sharedInstance().playSoundEffect("impacto.mp3")
            }
        }
        
    }
    
    func redirectingToGameScene() {
        //Direcionando para a página principal
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            //removendo pai do HighScore pois se não, quando voltar para essa tela, vai dar erro ao tentar adicionar um pai no HighScore ja que ele ja teria um
            Score.shared.scoreLabel.removeFromParent()
            //Removendo também das vidas do personagem
            self.character.characterToRemoveLifesFromParent()
            
            let telaGameScene = GameScene(size: self.frame.size)
            telaGameScene.scaleMode = .aspectFill
            self.view?.presentScene(telaGameScene, transition: SKTransition.fade(with: .black, duration: 0))
        }
        
    }
            
        
    
    
    //Função que detecta o contato dos corpos
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        if (firstBody.categoryBitMask == PhysicsCategory.character && secondBody.categoryBitMask == PhysicsCategory.gate) ||
            (firstBody.categoryBitMask == PhysicsCategory.gate && secondBody.categoryBitMask == PhysicsCategory.character) {
            
            if self.collisionAllowed {
                self.waitingForCharacterToActivateGateAnimation()
                self.generatingGhostOfCharacter()
                self.redirectingToGameScene()
            }
            
            //Deixando a colisao permitida igual a false para o fator invencibilidade do personagem
            self.collisionAllowed = false
            
        }
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
    
    }
}
