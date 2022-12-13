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
    
    private var gateStatic = GateObstacle()
    private var gateDynamic = GateObstacle()
    private var animationOfGate: SKAction? = nil
    
    private var collisionAllowed = true
    
    private var ground = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //Setando propriedades do personagem principal vivo
        self.character.characterView = AnimatedObject("personagem_vivo")
        self.character.characterView = character.characterToApplyProperties(character: character.characterView, view: self)
        self.character.characterView = character.characterToCollide(character: character.characterView)
        self.character.characterLife = character.characterLifeToSetProperties(characterLife: self.character.characterLife, view: self)
        
        //Criando background animado
        self.creatingAnimatedBackground()
        
        //Criando o objeto solo
        self.ground = groundToCreate(ground: SKSpriteNode(imageNamed: "chao"))
        self.ground.zPosition = 2
        
        //Criando portao estático e setando suas propriedades
        self.gateStatic.obstacleView = SKSpriteNode(imageNamed: "portao")
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
    
    func creatingStaticGate(gate: SKSpriteNode) -> SKSpriteNode {
        
        gate.setScale(0.2)
        gate.position = CGPoint(x: self.frame.width, y: self.ground.frame.height + (gate.frame.height / 2))
        gate.zPosition = 2
        
        gate.physicsBody = SKPhysicsBody(texture: gate.texture!, size: gate.size)
        gate.physicsBody?.isDynamic = false
        gate.physicsBody?.affectedByGravity = false
        
        gate.physicsBody?.categoryBitMask = PhysicsCategory.gate
        gate.physicsBody?.contactTestBitMask = PhysicsCategory.character
        
        return gate
    }
    
    //Criando portão dinâmico que será adicionado no momento em que o personagem fazer contato com o portao
    func creatingDynamicGate(gate: SKSpriteNode) -> SKSpriteNode {
        
        let newGate = AnimatedObject("portao")
        newGate.setScale(0.2)
        newGate.position = CGPoint(x: self.frame.width / 2, y: self.ground.frame.height + (gate.frame.height / 2))
        newGate.zPosition = 2
        
        return gate
    }

    //Função que estrutura toda a parte do background animado
    func creatingAnimatedBackground() -> Void{
        let moveBackground = SKAction.moveBy(x: -self.frame.width * 2, y: 0, duration: 13)
        let resizeBackground = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let reDo = SKAction.repeat((SKAction.sequence([moveBackground, resizeBackground])), count: 1)

        for i in 0..<2 {
            if(i == 1) {
                self.backgroundImage = SKSpriteNode(imageNamed: "bg")
            } else {
                self.backgroundImage = SKSpriteNode(imageNamed: "background_inicio")
            }
            

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
    
    //Função que detecta o contato dos corpos
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        if (firstBody.categoryBitMask == PhysicsCategory.character && secondBody.categoryBitMask == PhysicsCategory.gate) ||
            (firstBody.categoryBitMask == PhysicsCategory.gate && secondBody.categoryBitMask == PhysicsCategory.character) {
            
            if self.collisionAllowed {
                self.gateDynamic.obstacleView = self.creatingDynamicGate(gate: self.gateStatic.obstacleView)
                
                self.gateStatic.obstacleView.removeAllActions()
                self.gateStatic.obstacleView.removeFromParent()
                self.addChild(self.gateDynamic.obstacleView)
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
