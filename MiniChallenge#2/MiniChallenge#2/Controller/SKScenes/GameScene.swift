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
    
    private var gameStarted = false
    
    //Variável utilizada para auxiliar na lógica de movimento dos objetos
    private var movedActionOfObstacles = SKAction()
    private var obstaclesInAction = SKNode()
    
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
    
        func settingPropertiesObstacle(obstacle: Obstacle, obstacleView: SKSpriteNode, zPosition: CGFloat) -> SKSpriteNode {
            obstacle.obstacleView = obstacleView
            obstacle.obstacleView = obstacle.obstacleToSetSize(obstacle: obstacle.obstacleView, obZPosition: zPosition)
            obstacle.obstacleView = obstacle.obstacleToSetPhysics(obstacle: obstacle.obstacleView)
            obstacle.obstacleView = obstacle.obstacleToCollide(obstacle: obstacle.obstacleView)
            
            return obstacleView
        }
    
        func sortObstacle() -> Obstacle {
            let obstacleSorted = Int.random(in: 0...3)
            
            switch obstacleSorted {
            case 0:
                let birdObstacle = BirdObstacle()
                
                birdObstacle.obstacleView = settingPropertiesObstacle(obstacle: birdObstacle, obstacleView: AnimatedObject("corvo"), zPosition: 9)
                
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                birdObstacle.actionObstacle = SKAction.moveBy(x: 0, y: -self.frame.height / 2, duration: 0.004 * distance)
                birdObstacle.obstacleView.position.y = self.frame.height
                return birdObstacle
            case 1:
                let tombstoneObstacle = TombstoneObstacle()
                
                tombstoneObstacle.obstacleView = settingPropertiesObstacle(obstacle: tombstoneObstacle, obstacleView: SKSpriteNode(imageNamed: "lapide1"), zPosition: 9)
                
                tombstoneObstacle.obstacleView.position.y = 0 + 20 //mudar 20 pelo tamanho do chão
                return tombstoneObstacle
            case 2:
                let ghostObstacle = GhostObstacle()
                
                ghostObstacle.obstacleView = settingPropertiesObstacle(obstacle: ghostObstacle, obstacleView: AnimatedObject("fantasma"), zPosition: 9)
                
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                ghostObstacle.actionObstacle = SKAction.moveBy(x: 0, y: -self.frame.height / 1.5, duration: 0.004 * distance)
                ghostObstacle.obstacleView.position.y = self.frame.height
                return ghostObstacle
            case 3:
                let handObstacle = HandObstacle()
                
                handObstacle.obstacleView = settingPropertiesObstacle(obstacle: handObstacle, obstacleView: AnimatedObject("maos"), zPosition: 9)
                
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                handObstacle.actionObstacle = SKAction.moveBy(x: 0, y: self.frame.height / 6, duration: 0.004 * distance)
                handObstacle.obstacleView.position.y = 0 + 20 //mudar 20 pelo tamanho do chão
                return handObstacle
            default:
                let birdObstacle = BirdObstacle()
                birdObstacle.obstacleView.position.y = self.frame.height * 2
                return birdObstacle
            }
        }
    
        func generatingNewObstacle() {
            
            self.obstaclesInAction = SKNode()
            
            let sortedObstacle = self.sortObstacle()
//
//            //Sorteando obstáculos para cada obstaculo presente na tela de forma com que não se repitam
//            var secondObstacle = self.sortObstacle()
//            repeat {
//                secondObstacle = self.sortObstacle()
//            } while(firstObstacle.obstacleView == secondObstacle.obstacleView)
//
//            //Sorteando obstáculos para cada obstaculo presente na tela de forma com que não se repitam
//            var tertiaryObstacle = self.sortObstacle()
//            repeat {
//                tertiaryObstacle = self.sortObstacle()
//            } while(firstObstacle.obstacleView == tertiaryObstacle.obstacleView || secondObstacle.obstacleView == tertiaryObstacle.obstacleView)
                    
            sortedObstacle.obstacleView.position.x = self.frame.width + (self.frame.width / 4)
//            secondObstacle.obstacleView.position.x = self.frame.width + (self.frame.width / 2)
//            tertiaryObstacle.obstacleView.position.x = self.frame.width + self.frame.width
                    
            sortedObstacle.obstacleView.setScale(0.15)
//            secondObstacle.obstacleView.setScale(0.15)
//            tertiaryObstacle.obstacleView.setScale(0.15)
                    
            sortedObstacle.obstacleView.physicsBody = SKPhysicsBody(rectangleOf: sortedObstacle.obstacleView.size)
            sortedObstacle.obstacleView.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
            sortedObstacle.obstacleView.physicsBody?.collisionBitMask = PhysicsCategory.character
            sortedObstacle.obstacleView.physicsBody?.contactTestBitMask = PhysicsCategory.character
            sortedObstacle.obstacleView.physicsBody?.affectedByGravity = false
            sortedObstacle.obstacleView.physicsBody?.isDynamic = false
                    
//            secondObstacle.obstacleView.physicsBody = SKPhysicsBody(rectangleOf: secondObstacle.obstacleView.size)
//            secondObstacle.obstacleView.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
//            secondObstacle.obstacleView.physicsBody?.collisionBitMask = PhysicsCategory.character
//            secondObstacle.obstacleView.physicsBody?.contactTestBitMask = PhysicsCategory.character
//            secondObstacle.obstacleView.physicsBody?.affectedByGravity = false
//            secondObstacle.obstacleView.physicsBody?.isDynamic = false
//
//            tertiaryObstacle.obstacleView.physicsBody = SKPhysicsBody(rectangleOf: tertiaryObstacle.obstacleView.size)
//            tertiaryObstacle.obstacleView.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
//            tertiaryObstacle.obstacleView.physicsBody?.collisionBitMask = PhysicsCategory.character
//            tertiaryObstacle.obstacleView.physicsBody?.contactTestBitMask = PhysicsCategory.character
//            tertiaryObstacle.obstacleView.physicsBody?.affectedByGravity = false
//            tertiaryObstacle.obstacleView.physicsBody?.isDynamic = false
                    
            self.obstaclesInAction.zPosition = 7
                    
            sortedObstacle.obstacleView.run(sortedObstacle.actionObstacle)
//            secondObstacle.obstacleView.run(secondObstacle.actionObstacle)
//            tertiaryObstacle.obstacleView.run(tertiaryObstacle.actionObstacle)
            self.obstaclesInAction.addChild(sortedObstacle.obstacleView)
//            self.obstaclesInAction.addChild(secondObstacle.obstacleView)
//            self.obstaclesInAction.addChild(tertiaryObstacle.obstacleView)
            self.obstaclesInAction.run(self.movedActionOfObstacles)
            self.addChild(obstaclesInAction)
        }
        
        func creatingMoveOfObstacle() {
            let spawn = SKAction.run({ () in
                self.generatingNewObstacle()
            })
            
            let delay = SKAction.wait(forDuration: 2.5)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            
            let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
            let movePipes = SKAction.moveBy(x: -distance - 300, y: 0, duration: 0.004 * distance)
            let removePipes = SKAction.removeFromParent()
            self.movedActionOfObstacles = SKAction.sequence([movePipes, removePipes])
        }
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.gameStarted {
            self.gameStarted = true
            
            self.menu.tapToStart()
            self.creatingMoveOfObstacle()
        } else {
            self.character.characterView = self.character.characterToFly(character: self.character.characterView)
        }
        
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
