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
        self.character.characterView = AnimatedObject("personagem_alma")
        self.character.characterView = character.characterToApplyProperties(character: character.characterView, view: self)
        self.character.characterView = character.characterToCollide(character: character.characterView)
        self.character.characterLife = character.characterLifeToSetProperties(characterLife: self.character.characterLife, view: self)
        
        //Criando o objeto solo
        self.ground = groundToCreate(ground: SKSpriteNode(imageNamed: "chao"))
        
        //Adicionando os filhos à autoclasse
        self.addChild(self.menu)
        self.addChild(self.character.characterView)
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
        }
    }
    
    //MARK: - Criando objetos da cena principal
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
    
        //Função utilizada para organizar melhor o código no switch case
        func settingPropertiesObstacle(obstacle: Obstacle, obstacleView: SKSpriteNode, zPosition: CGFloat) -> SKSpriteNode {
            obstacle.obstacleView = obstacleView
        
            obstacle.obstacleView = obstacle.obstacleToSetSize(obstacle: obstacle.obstacleView, obZPosition: zPosition)
            obstacle.obstacleView = obstacle.obstacleToSetPhysics(obstacle: obstacle.obstacleView)
            obstacle.obstacleView = obstacle.obstacleToCollide(obstacle: obstacle.obstacleView)
            
            return obstacleView
        }
    
        //
        func sortObstacle() -> Obstacle {
            let obstacleSorted = Int.random(in: 0...3)
            
            //Criando os objetos do tipo do obstaculo sorteado e setando as devidas propriedades
            switch obstacleSorted {
            case 0:
                let birdObstacle = BirdObstacle()
                birdObstacle.obstacleView = AnimatedObject("corvo")
                birdObstacle.obstacleView.setScale(0.15)
                birdObstacle.obstacleView.size = CGSize(width: 100, height: 50)
                birdObstacle.obstacleView = settingPropertiesObstacle(obstacle: birdObstacle, obstacleView: birdObstacle.obstacleView, zPosition: 9)
                
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                birdObstacle.actionObstacle = SKAction.moveBy(x: -distance, y: -CGFloat(Int.random(in: 1...250)), duration: 0.004 * distance)
                birdObstacle.obstacleView.position.y = self.frame.height - CGFloat(Int.random(in: 50...100))
                return birdObstacle
            case 1:
                let tombstoneObstacle = TombstoneObstacle()
                tombstoneObstacle.obstacleView = SKSpriteNode(imageNamed: "lapide1")
                tombstoneObstacle.obstacleView.setScale(0.15)
                tombstoneObstacle.obstacleView.size = CGSize(width: 150, height: 75)
                tombstoneObstacle.obstacleView = settingPropertiesObstacle(obstacle: tombstoneObstacle, obstacleView: tombstoneObstacle.obstacleView, zPosition: 9)
                
                tombstoneObstacle.obstacleView.position.y = self.ground.frame.height + (tombstoneObstacle.obstacleView.frame.height / 2)
                return tombstoneObstacle
            case 2:
                let ghostObstacle = GhostObstacle()
                ghostObstacle.obstacleView = AnimatedObject("fantasma")
                ghostObstacle.obstacleView.setScale(0.15)
                ghostObstacle.obstacleView.size =  CGSize(width: 100, height: 100)
                ghostObstacle.obstacleView = settingPropertiesObstacle(obstacle: ghostObstacle, obstacleView: ghostObstacle.obstacleView, zPosition: 9)
                
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                ghostObstacle.actionObstacle = SKAction.moveBy(x: 0, y: (-self.frame.height / 1.5) + CGFloat(Int.random(in: -50...150)), duration: 0.004 * distance)
                ghostObstacle.obstacleView.position.y = self.frame.height
                return ghostObstacle
            case 3:
                let handObstacle = HandObstacle()
                handObstacle.obstacleView = AnimatedObject("maos")
                handObstacle.obstacleView.setScale(0.15)
                handObstacle.obstacleView.size = CGSize(width: 100, height: 50)
                handObstacle.obstacleView = settingPropertiesObstacle(obstacle: handObstacle, obstacleView: handObstacle.obstacleView , zPosition: 9)
                
                let distance = CGFloat(self.frame.width + self.obstaclesInAction.frame.width)
                handObstacle.actionObstacle = SKAction.moveBy(x: 0, y: self.frame.height / 6, duration: 0.004 * distance)
                handObstacle.obstacleView.position.y = self.ground.frame.height //mudar 20 pelo tamanho do chão
                return handObstacle
            default:
                //Obstaculo poadrão
                let birdObstacle = BirdObstacle()
                birdObstacle.obstacleView.position.y = self.frame.height * 2
                return birdObstacle
            }
        }
    
        //Função que chama a função que gera os obstáculos, seta as propriedades dos mesmos e adiciona na cena
        func generatingNewObstacle() {
            
            self.obstaclesInAction = SKNode()
            
            let sortedObstacle = self.sortObstacle()
                    
            sortedObstacle.obstacleView.position.x = self.frame.width + (self.frame.width / 4)
                    
            sortedObstacle.obstacleView.physicsBody = SKPhysicsBody(rectangleOf: sortedObstacle.obstacleView.size)
            sortedObstacle.obstacleView.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
            sortedObstacle.obstacleView.physicsBody?.collisionBitMask = PhysicsCategory.character
            sortedObstacle.obstacleView.physicsBody?.contactTestBitMask = PhysicsCategory.character
            sortedObstacle.obstacleView.physicsBody?.affectedByGravity = false
            sortedObstacle.obstacleView.physicsBody?.isDynamic = false
                    
            self.obstaclesInAction.zPosition = 7
                    
            sortedObstacle.obstacleView.run(sortedObstacle.actionObstacle)
            self.obstaclesInAction.addChild(sortedObstacle.obstacleView)
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
