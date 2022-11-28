//
//  GameScene.swift
//  MiniChallenge#2
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 16/11/22.
//

import SpriteKit
import GameplayKit

//Score.shared.addScore() usar essa func para adicionar score quando tiver
//Score.shared.trySaveHighScore() usar essa func para salvar o highscore


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let menu = Menu()
    private let character = Character.character
    private let obstacle = BirdObstacle()
    private var ground: SKSpriteNode = SKSpriteNode()
    
    var backgroundImage: SKSpriteNode = SKSpriteNode()
    let objectDummy = SKNode()
    let moveAction = SKAction.moveTo(x: -100, duration: 5)
    let removeAction = SKAction.removeFromParent()
    
    override func didMove(to view: SKView) {
        
        //Relacionando o SKPhysicsContactDelegate à classe self
        self.physicsWorld.contactDelegate = self
        
        //Chamando a função que estrutura o menu principal
        self.menu.menuToStruct(sizeView: self.size)
        
        
        self.creatingAnimatedBackground()
        
        //Criando e chamando as funções que fazem a estrutura do personagem
        self.character.characterView = AnimatedObject("personagem")
        self.character.characterView = character.characterToApplyProperties(character: character.characterView, view: self)
        self.character.characterView = character.characterToCollide(character: character.characterView)
        
        //Criando e chamando as funções que fazem a estrutura do obstáculo
        //obstacle.obstacleView = obstacle.obstacleToCollide(obstacle: obstacle.obstacleView)
        //obstacle.obstacleView.position = CGPoint(x: self.frame.width / 2 - obstacle.obstacleView.frame.width, y: self.frame.height / 2)
        
        //Criando o objeto solo
        self.ground = groundToCreate(ground: self.ground)
        self.character.characterLife = character.characterLifeToSetProperties(characterLife: self.character.characterLife, view: self)
        
        //Adicionando os filhos à autoclasse
        self.addChild(self.menu)
        self.addChild(self.character.characterView)
//        self.addChild(obstacle.obstacleView)
        self.addChild(self.ground)
        self.addChild(objectDummy)
        for life in self.character.characterLife {
            self.addChild(life)
        }
    }
    
    //Função que detecta o contato dos corpos
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        //Estrutura condicional que verifica os corpos de contato
        if firstBody.categoryBitMask == PhysicsCategory.character && secondBody.categoryBitMask == PhysicsCategory.obstacle || firstBody.categoryBitMask == PhysicsCategory.obstacle && secondBody.categoryBitMask == PhysicsCategory.character {
            
            //Decrementando itens da lista de vidas do jogo
            if !self.character.characterLife.isEmpty {
                self.character.characterLife.last?.removeFromParent()
                self.character.characterLife.removeLast()
            }
            self.character.characterView = character.characterToFly(character: self.character.characterView)
        }
    }
    
    //MARK: - Criando objetos da cena principal
        func groundToCreate(ground: SKSpriteNode) -> SKSpriteNode {
            ground.size = CGSize(width: self.frame.width, height: 100)
            ground.position = CGPoint(x: 0, y: 0)
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.isDynamic = false
            ground.physicsBody?.affectedByGravity = false
            
            ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
            ground.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
            ground.physicsBody?.contactTestBitMask = PhysicsCategory.character | PhysicsCategory.obstacle
            
            return ground
        }
    
        //Função que estrutura toda a parte do background animado
        func creatingAnimatedBackground() {
            let moveBackground = SKAction.moveBy(x: -self.size.width, y: 0, duration: 5)
            let resizeBackground = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
            let reDo = SKAction.repeatForever(SKAction.sequence([moveBackground, resizeBackground]))
            
            for i in 0..<2 {
                self.backgroundImage = SKSpriteNode(imageNamed: "bg")
                
                self.backgroundImage.anchorPoint = CGPoint(x: 0, y:0)
                
                self.backgroundImage.size.width = self.size.width //get the right pixel on phone
                self.backgroundImage.size.height = self.size.height
                self.backgroundImage.zPosition = -1 //Z positions define what itens comes in front goes from ex: 0,1,2,3 etc
                self.backgroundImage.position = CGPoint(x:self.size.width * CGFloat(i), y:0)
                self.backgroundImage.run(reDo)
                
                self.objectDummy.addChild(backgroundImage)
            }
            
            self.objectDummy.speed = 1
        }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        menu.tapToStart()
        self.character.characterView = self.character.characterToFly(character: self.character.characterView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if menu.testeBg == 1{
            
            backgroundImage = SKSpriteNode(imageNamed: "bg2")
            
            
        }
        
        
        else if menu.testeBg == 2 {
           
            backgroundImage = SKSpriteNode(imageNamed: "bg1")
            
        }
        
        
        
    }
}
